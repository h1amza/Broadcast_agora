import 'package:flutter/material.dart';
import 'package:flutter_app_agora/AppScreen/dashboard.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:flutter_app_agora/services/jsonApiLogin.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {

  TextEditingController _password1 = TextEditingController();
  TextEditingController _password2 = TextEditingController();
  bool show = true;
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
          'Reset Password',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30,),
              Icon(
                Icons.vpn_key,
                size: 140,
                color: Colors.indigo,
              ),
              SizedBox(height: 20,),
              Text(
                'Entre new Password',
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50,),
              txtEdForm(_password1,'Password',Icon(Icons.vpn_key,color: Colors.indigo,),TextInputType.text,show),
              SizedBox(height: 15,),
              txtEdForm(_password2,'Confirme Password',Icon(Icons.vpn_key,color: Colors.indigo,),TextInputType.text,show),
              SizedBox(height: 50,),
              InkWell(
                onTap: () async {
                  if(_password1.text.isNotEmpty&&_password2.text.isNotEmpty){
                    if(_password1.text.toString() == _password2.text.toString()){
                      ProgressDialog pr=prDialog(context);
                      pr.show();
                      String t = await JsonApiLogin.changePassword(_password1.text.toString());
                      pr.hide();
                      if(t=='true'){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => DashboardScreen(0),),
                        );
                      }
                      else flushBarShow(context,t);
                    }
                    else flushBarShow(context,'password1 != password2');
                  }
                  else flushBarShow(context,'Invalide data');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: buttonForm(context,'Confirme'),
                ),
              ),
              SizedBox(height: 250)
            ],
          ),
        ),
      ),
    );
  }
}