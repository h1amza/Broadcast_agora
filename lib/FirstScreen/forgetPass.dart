import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:flutter_app_agora/FirstScreen/verification.dart';
import 'package:flutter_app_agora/services/jsonApiLogin.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController _email = TextEditingController();
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
          'Forgot Password',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30,),
                  Icon(
                    Icons.lock,
                    size: 140,
                    color: Colors.indigo,
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Text(
                      'Entre Your Email to Forgot Password',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 50,),
                  txtEdForm(_email,'Email',Icon(Icons.mail_outline,color: Colors.indigo,),TextInputType.emailAddress,false),
                  SizedBox(height: 80,),
                  Padding(
                      padding: const EdgeInsets.only(right: 25,left: 25),
                      child: InkWell(
                        onTap: () async {
                          if(_email.text.isNotEmpty){
                            if(EmailValidator.validate(_email.text.toString())){
                              ProgressDialog pr=prDialog(context);
                              pr.show();
                              String t = await JsonApiLogin.forgotPassword(_email.text.toString());
                              pr.hide();
                              if(t=='true'){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Verification(screenBef: 'for',),),
                                );
                              }
                              else flushBarShow(context,t);
                            }
                            else flushBarShow(context,'Entre a Valide Form Email');
                          }
                          else flushBarShow(context,'Entre Email');
                        },
                        child: buttonForm(context,'Send')
                      ),
                    ),
                  SizedBox(height: 300,),
                ],
          ),
        ),
      ),
    );
  }
}
