import 'package:flutter/material.dart';
import 'package:flutter_app_agora/FirstScreen/login.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:flutter_app_agora/Model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addBroadcast.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>{

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _createHeader(),
              _createDrawerItem(icon: Icons.add_box, text: 'Organize Your Broadcast',
                  onTap: () {
                if(ModelUser.newUser.role == '0'|| ModelUser.newUser.role == '2'){
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>AddBroadcast()));
                }
                else flushBarShow(context,'You ar note an admis');
              }),
              _createDrawerItem(icon: Icons.favorite, text: 'Favorite Broadcast', onTap: () {}),
              Divider(),
              _createDrawerItem(icon: Icons.exit_to_app, text: 'Deconecter', onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('token','');
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>LogIn()));
              }),
              Divider(),
            ],
          ),
      ),
    );
  }
  Widget _createHeader() {
    return Container(
      height: 120,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(color: Colors.green[600]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "===>  ${ModelUser.newUser.userName}  <===",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}){
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
