import 'package:flutter/material.dart';
import 'package:flutter_app_agora/AppScreen/dashboard.dart';
import 'package:flutter_app_agora/services/jsonApiLogin.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future checkDirectionRoute() async {
    String t = await JsonApiLogin.checkToken();
    if(t=='true'){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(0),),
      );
    }
    else Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogIn(),),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      checkDirectionRoute();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.perm_camera_mic,size: 140,color: Colors.blue[900],),
              Text('Bakar Bakar',style: TextStyle(fontSize: 25),),
              SizedBox(height: 50,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}