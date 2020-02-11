import 'package:flutter/material.dart';
import 'package:flutter_app_agora/AppScreen/dashboard.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'changePass.dart';
import 'package:flutter_app_agora/services/jsonApiLogin.dart';


class Verification extends StatefulWidget {
  String screenBef;
  Verification({this.screenBef});

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {

  String currentText='';

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed:(){
            Navigator.pop(context);
          } ,
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: Text(
          'Verification Code',
          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black,),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/cover1.jpg'),
                fit: BoxFit.cover
            ),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40,),
              Icon(
                Icons.phonelink_lock,
                size: 140,
                color: Colors.indigo,
              ),
              SizedBox(height: 40,),
              Text(
                'You Receive the Code in Email',
                style: TextStyle(fontSize: 22),
              ),
              Text(
                'Just Stay Soon',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20),
                child: PinCodeTextField(
                  length: 6,
                  //controller: ,
                  backgroundColor: Colors.white70,
                  obsecureText: false,
                  animationType: AnimationType.fade,
                  shape: PinCodeFieldShape.box,
                  borderWidth: 1,
                  animationDuration: Duration(milliseconds: 300),
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  onChanged: (value) {
                    setState(() {
                      currentText = value;
                      print(currentText);
                    });
                  },
                ),
              ),
              SizedBox(height: 60,),
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20),
                child: InkWell(
                    onTap:()async{
                      print(currentText);
                      if(currentText !=null){
                        final prefs = await SharedPreferences.getInstance();
                        String code = prefs.getString('code');
                        if(currentText == code){
                          ProgressDialog pr = prDialog(context);
                          pr.show();
                          bool t = await JsonApiLogin.validCode();
                          pr.hide();
                          if(t){
                            if(widget.screenBef=='sign' || widget.screenBef=='login'){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => DashboardScreen(0),),
                              );
                            }
                            else
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChangePass(),),
                              );
                          }
                          else flushBarShow(context, 'ERROR');

                        }
                        else flushBarShow(context,'Invalide Code');
                      }
                      else flushBarShow(context,'Entre Code');

                    },
                    child: buttonForm(context,'Next')
                ),
              ),
              SizedBox(height: 250,),
            ],
          ),
        ),
      ),
    );
  }
}
