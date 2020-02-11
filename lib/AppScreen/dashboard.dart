import 'package:flutter/material.dart';
import 'package:flutter_app_agora/AppScreen/homeScreen.dart';

import 'broadCastFinished.dart';
import 'broadCastLiveScreen.dart';
import 'contactUsScreen.dart';
import 'futureBroadcast.dart';


class DashboardScreen extends StatefulWidget {
  int i;
  DashboardScreen(this.i);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

int indexGlobal=0;

class _DashboardScreenState extends State<DashboardScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    indexGlobal=widget.i;
  }

  final tabs=[
    HomeScreen(),
    FinishedBroadCast(),
    FutureBroadCast(),
    Center(child: Text('BroadCastLive()')),//BroadCastLive(),
    ContactScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[indexGlobal],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexGlobal,
        selectedFontSize: 1,
        unselectedFontSize: 1,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo[800],
        selectedItemColor: Colors.green[500],
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.mic_none),
              title: Text(''),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              title: Text(''),
              backgroundColor: Colors.indigo[600]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              title: Text(''),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.streetview),
              title: Text(''),
          ),
        ],
        onTap: (index){
          setState(() {
            indexGlobal = index;
          });
        },
      ),
    );
  }
}
