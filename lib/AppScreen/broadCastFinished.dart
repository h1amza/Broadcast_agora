import 'package:flutter/material.dart';
import 'package:flutter_app_agora/Model/ModelBroadcast.dart';
import 'package:flutter_app_agora/services/jsonApiBroadcast.dart';
import 'customCardModel.dart';
import 'drawerScreen.dart';

class FinishedBroadCast extends StatefulWidget {
  @override
  _FinishedBroadCastState createState() => _FinishedBroadCastState();
}

class _FinishedBroadCastState extends State<FinishedBroadCast> {

  final GlobalKey _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              firstPosition(context),
              secondPosition(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstPosition(context){
    return Container(
      height: 105,
      child: Stack(
        children: <Widget>[
          Container(
            height:100,
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
            right: 0,
            left: 0,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(),
                      Text('BroadCast',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
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
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget secondPosition(context){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height-200,
            child: Padding(
              padding: const EdgeInsets.only(right: 15,left: 15),
              child: FutureBuilder(
                future: JsonApiBrodCast.allBroadCastFinished(),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return Icon(Icons.error,size: 28,);
                    }
                    else return customCard(ModelBroadCast.listModelBroadCastFuture,2);
                  }
                  else return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}