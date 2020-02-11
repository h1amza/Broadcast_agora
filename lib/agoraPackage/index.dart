import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              SizedBox(height: 5,),
              InkWell(
                onTap: (){onJoin('x1');},
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'x1 channel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){onJoin('hamza');},
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'hamza channel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin(String channelName) async {
      // update input validation
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: channelName,
          ),
        ),
      );
    //}
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [
        //PermissionGroup.camera,
        PermissionGroup.microphone
      ],
    );
  }
}
