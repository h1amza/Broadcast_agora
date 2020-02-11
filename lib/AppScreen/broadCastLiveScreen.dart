import 'package:flutter/material.dart';
import 'package:flutter_app_agora/Model/ModelBroadcast.dart';
import 'package:flutter_app_agora/agoraPackage/call.dart';
import 'drawerScreen.dart';

class BroadCastLive extends StatefulWidget {
  ModelBroadCast modelBroadCast;
  BroadCastLive(this.modelBroadCast);
  @override
  _BroadCastLiveState createState() => _BroadCastLiveState();
}

class _BroadCastLiveState extends State<BroadCastLive> {

  final GlobalKey _scaffoldKey = new GlobalKey<ScaffoldState>();
  double value=0;

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
              SizedBox(height: 15,),
              //secondPosition(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstPosition(context){
    return Container(
      height: 420,
      child: Stack(
        children: <Widget>[
          Container(
            height: 260,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,color:Colors.white,size: 35,),
                        ),
                      ),
                    ),
                    Text('Live BroadCast',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    Container()
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  height: 300,
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
                  child: CallPage(channelName: widget.modelBroadCast.id,modelBroadCast: widget.modelBroadCast,),
                  //LiveUi(widget.modelBroadCast),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget secondPosition(context){
    return Padding(
      padding: const EdgeInsets.only(right: 25,left: 25),
      child: Container(
        child: Column(
          children: <Widget>[
            TextField(
              //controller: description,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: 'Comment',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){},
                  child: Text('Text 1'),
                ),
                RaisedButton(
                  onPressed: (){},
                  child: Text('Text 2'),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3, 3),
                      blurRadius: 0,
                    ),
                  ]
              ),
              child: Column(
                children: <Widget>[
                  commentUi()
                ],
              ),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }

  Widget commentUi(){
    return Container();
  }

}