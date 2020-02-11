import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_agora/AppScreen/dashboard.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:flutter_app_agora/FirstScreen/verification.dart';
import 'package:flutter_app_agora/services/jsonApiLogin.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'signup.dart';
import 'forgetPass.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool show = true;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
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
                SizedBox(height: 15,),
                Container(
                  height: MediaQuery.of(context).size.height/2.5,
                  child: Icon(
                    Icons.perm_camera_mic,
                    size: 55,
                    color: Colors.indigo,
                  ),
                ),
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.indigo),
                ),
                SizedBox(height: 40,),
                txtEdForm(_email,'Email',Icon(Icons.mail_outline,color: Colors.indigo,),TextInputType.emailAddress,false),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(right: 25,left: 25),
                  child: TextFormField(
                    controller: _password,
                    obscureText: show,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          show = !show;
                        });
                      },
                        icon: show?Icon(Icons.visibility,color: Colors.indigo,):Icon(Icons.visibility_off,color: Colors.indigo),
                      ),
                      prefixIcon: Icon(Icons.vpn_key,color: Colors.indigo,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgetPass(),),
                        );
                      },
                      child:  Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 18,color: Colors.indigo),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25,left: 25),
                  child: InkWell(
                    onTap: () async {
                      signInMethode(context);
                    },
                    child: buttonForm(context,'LOGIN'),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15,left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "You don't have an Account?",
                            style: TextStyle(fontSize: 18,color: Colors.white),
                          ),
                          FlatButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUp(),),
                              );
                            },
                            child:  Text(
                              "Sign In",
                              style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                    ),
                  ),
                ),
                SizedBox(height: 2,),
              ],
            ),
          ),
      ),
    );
  }

  void signInMethode(context)async{
    if(_email.text.isNotEmpty && _password.text.isNotEmpty){
      if(EmailValidator.validate(_email.text.toString())){
        ProgressDialog pr=prDialog(context);
        pr.show();
        String t = await JsonApiLogin.signIn(_email.text.toString(), _password.text.toString());
        pr.hide();
        if(t=='true'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  DashboardScreen(0),),
          );
        }else{
          if(t=='false1'){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Verification(
                screenBef: 'login',
              ),),
            );
          }
          else flushBarShow(context,t);
        }
      }else flushBarShow(context,"ENTRE A VALIDE FORM EMAIL");
    }
    else flushBarShow(context,"ENTRE VALIDE DATA");
  }
}
