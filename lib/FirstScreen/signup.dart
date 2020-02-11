import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:flutter_app_agora/FirstScreen/verification.dart';
import 'package:flutter_app_agora/services/jsonApiLogin.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _first = TextEditingController();
  TextEditingController _last = TextEditingController();
  bool show = true;
  int group = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white38,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue[900],
          ),
        ),
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
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Icon(
                  Icons.perm_camera_mic,
                  size: 55,
                  color: Colors.indigo,
                ),
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _first,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                    Container(
                      width: 3,
                      height: 40,
                      color: Colors.indigo,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _last,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              txtEdForm(
                  _username,
                  'Username',
                  Icon(
                    Icons.person_outline,
                    color: Colors.indigo,
                  ),
                  TextInputType.text,false),
              SizedBox(
                height: 20,
              ),
              txtEdForm(
                  _email,
                  'Email',
                  Icon(
                    Icons.mail_outline,
                    color: Colors.indigo,
                  ),
                  TextInputType.emailAddress,false),
              SizedBox(
                height: 20,
              ),
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sexe:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text('Woman'),
                    Radio(
                      value: 1,
                      groupValue: group,
                      activeColor: Colors.red,
                      onChanged: (t) {
                        setState(() {
                          group = t;
                        });
                      },
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text('Man'),
                    Radio(
                      value: 0,
                      groupValue: group,
                      activeColor: Colors.green,
                      onChanged: (t) {
                        setState(() {
                          group = t;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: InkWell(
                    onTap: () async {
                      ProgressDialog pr = prDialog(context);
                      signUpMethode(pr, context);
                    },
                    child: buttonForm(context, 'CREATE ACCOUNT')),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUpMethode(pr, context) async {
    if (_first.text.isNotEmpty &&
        _last.text.isNotEmpty &&
        _username.text.isNotEmpty &&
        _email.text.isNotEmpty &&
        _password.text.isNotEmpty) {
      if (EmailValidator.validate(_email.text.toString())) {
        pr.show();
        String r = await JsonApiLogin.signUp(
            _username.text.toString(),
            _last.text.toString(),
            _first.text.toString(),
            _email.text.toString(),
            _password.text.toString(),
            group);
        pr.hide();

        if (r == "true") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Verification(
                screenBef: 'sign',
              ),
            ),
          );
        } else
          flushBarShow(context, '$r');
      } else
        flushBarShow(context, 'ENTRE A VALIDE FORM EMAIL');
    } else
      flushBarShow(context, 'All DATA Is Required');
  }
}
