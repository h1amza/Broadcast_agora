import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

Widget txtEdForm(TextEditingController controller,String txt,Icon ic,TextInputType t,bool show){
  return Padding(
    padding: const EdgeInsets.only(right: 25,left: 25),
    child: TextFormField(
      controller: controller,
      obscureText: show,
      style: TextStyle(color: Colors.black),
      keyboardType: t,
      decoration: InputDecoration(
        hintText: '$txt',
        prefixIcon: ic,
      ),
    ),
  );
}
Widget buttonForm(context,String txt){
  return Container(
    height: 45,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.circular(10),
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.5, 0.7, 0.9],
        colors: [Colors.green[600], Colors.green[500], Colors.green[500], Colors.green[600],],
      ),
    ),
    child: Center(
      child: Text(
        txt,
        style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget flushBarShow(context,txt){
  return Flushbar(
    messageText: Center(
        child: Text(txt,
          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
    ),
    backgroundColor: Colors.blue,
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.white,
    icon: Icon(Icons.announcement,color: Colors.white,size: 25,),
  )..show(context);
}


ProgressDialog prDialog(context){
   ProgressDialog pr;
  pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
  pr.style(
      message: 'Loading...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      messageTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.w600
      ),
  );
  return pr;
}
