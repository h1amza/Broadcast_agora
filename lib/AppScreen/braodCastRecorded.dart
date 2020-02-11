import 'package:flutter/material.dart';
import 'package:flutter_app_agora/Model/userModel.dart';

class BroadCastRecorded extends StatefulWidget {
  @override
  _BroadCastRecordedState createState() => _BroadCastRecordedState();
}

class _BroadCastRecordedState extends State<BroadCastRecorded> {

  final GlobalKey _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              firstPosition(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstPosition(context){
    return Container(
      height: 470,
      child: Stack(
        children: <Widget>[
          Container(
            height: 280,
            decoration: BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                  image: AssetImage('assets/images/cover2.jpg'),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Positioned(
            top: 45,
            bottom: 0,
            right: 20,
            left: 20,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(ModelUser.newUser.userName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            Text(ModelUser.newUser.email,style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          var sc = GlobalKey<ScaffoldState>();
                          sc = _scaffoldKey;
                          sc.currentState.openDrawer();
                        },
                        icon: Icon(Icons.menu,color: Colors.white,size: 35,),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 360,
                  width: MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3, 3),
                          blurRadius: 0,
                        )
                      ]
                  ),
                  child: Column(
                    children: <Widget>[

                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
