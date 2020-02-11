import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:flutter_app_agora/Model/ModelBroadcast.dart';
import 'package:flutter_app_agora/services/jsonApiBroadcast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'braodCastRecorded.dart';
import 'package:timer_builder/timer_builder.dart';
import 'broadCastLiveScreen.dart';

class DetailBroadCast extends StatefulWidget {
  ModelBroadCast modelBroadCast;
  DateTime now;
  DetailBroadCast(this.modelBroadCast,this.now);
  @override
  _DetailBroadCastState createState() => _DetailBroadCastState();
}

class _DetailBroadCastState extends State<DetailBroadCast> {
  DateTime alert;
  bool reached;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    alert = widget.modelBroadCast.date;
    reached = widget.now.compareTo(alert) >= 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 60,),
              Center(
                child:widget.modelBroadCast.photo!=''?Container(
                  height:250,
                  child: CachedNetworkImage(
                    imageUrl: "https://bakarbakar.herokuapp.com/images/${widget.modelBroadCast.photo}",
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ):Container(height: 60,child: Text('Broadcast without Photo',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),),
              ),
              SizedBox(height: 5,),
                 Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                     child: Padding(
                       padding: const EdgeInsets.all(15),
                       child: Column(
                         children: <Widget>[
                           Row(
                             children: <Widget>[
                               Text('Title :'),
                               SizedBox(width: 25,),
                               Flexible(child: Text(widget.modelBroadCast.title)),
                             ],
                           ),
                           SizedBox(height: 25,),
                           Row(
                             children: <Widget>[
                               Text('Description :'),
                               SizedBox(width: 25,),
                               Flexible(child: Text(widget.modelBroadCast.description)),
                             ],
                           ),
                           SizedBox(height: 25,),
                           Row(
                             children: <Widget>[
                               Text('Collaboration :'),
                               SizedBox(width: 25,),
                               Flexible(child: Text(widget.modelBroadCast.collaboration.toString())),
                             ],
                           ),
                           SizedBox(height: 25,),
                           Row(
                             children: <Widget>[
                               Text('Recorded :'),
                               SizedBox(width: 25,),
                               Text(widget.modelBroadCast.recorded.toString())
                             ],
                           ),
                           SizedBox(height: 25,),
                           Row(
                             children: <Widget>[
                               Text('Date Broadcast :'),
                               SizedBox(width: 25,),
                               Flexible(child: Text("${DateFormat.yMMMd().format(widget.modelBroadCast.date)} / ${DateFormat.Hm().format(widget.modelBroadCast.date)}")),
                             ],
                           ),
                           SizedBox(height: 25,),
                           widget.modelBroadCast.finished && widget.modelBroadCast.accepted && widget.modelBroadCast.recorded&& widget.modelBroadCast.urlRecord!=null&& widget.modelBroadCast.urlRecord!=''?
                             Column(
                               children: <Widget>[
                                 Row(
                                   children: <Widget>[
                                     Text('Listen Broadcast :'),
                                     SizedBox(width: 25,),
                                     RaisedButton(
                                       onPressed: (){
                                         Navigator.push(context,MaterialPageRoute(builder: (context)=>BroadCastRecorded()));
                                       },
                                       child: Icon(Icons.volume_up,color: Colors.white,),
                                       color: Colors.indigo,
                                     )
                                     ],
                                 ),
                                 SizedBox(height: 25,),
                               ],
                             )
                               :Container(),
                           Container(
                             child: TimerBuilder.scheduled([alert],
                                   builder: (context) {
                                     // This function will be called once the alert time is reached
                                     var now = widget.now;
                                     reached = now.compareTo(alert) >= 0;

                                     final textStyle1 =TextStyle(color: Colors.green[800],fontSize: 20,fontWeight: FontWeight.bold);
                                     final textStyle2 =TextStyle(color: Colors.red[800],fontSize: 20,fontWeight: FontWeight.bold);

                                     return Center(
                                       child: Row(
                                         children: <Widget>[
                                           Icon(
                                             reached ? Icons.alarm_on: Icons.alarm,
                                             color: reached ? Colors.red: Colors.green,
                                             size: 48,
                                           ),
                                           Container(width: 25,child: Text(':',style:!reached ? textStyle1:textStyle2),),
                                           !reached ?
                                           Flexible(
                                             child: TimerBuilder.periodic(
                                                 Duration(seconds: 01),
                                                 alignment: Duration.zero,
                                                 builder: (context) {
                                                   // This function will be called every second until the alert time
                                                   var now = widget.now;
                                                   var remaining = alert.difference(now);
                                                   return Text(formatDuration(remaining), style: textStyle1,);
                                                 }
                                             ),
                                           )
                                               :
                                           Text("0s", style: textStyle2),

                                         ],
                                       ),
                                     );
                                   }
                               ),
                           ),

                           SizedBox(height: 5,),

                           !widget.modelBroadCast.finished &&widget.modelBroadCast.accepted&& reached?
                           (
                             RaisedButton(
                                   onPressed: ()async{
                                     ProgressDialog pr = prDialog(context);
                                     pr.show();
                                     String r = await JsonApiBrodCast.startBroadCast(widget.modelBroadCast.id);
                                     pr.hide();
                                     if(r=='true'){
                                      await onJoin(widget.modelBroadCast.id);
                                     }
                                   },
                                   child: Text('Join Live Broadcast',style: TextStyle(color: Colors.white),),
                                   color: Colors.indigo,
                             )
                           )
                               :
                           (Container()),

                         ],
                       ),
                     ),
                    ),
                ),
              SizedBox(height: 25,),
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
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>
        //CallPage(channelName: widget.modelBroadCast.id,),
        BroadCastLive(widget.modelBroadCast),
        ),
    );

  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [
        PermissionGroup.camera,
        PermissionGroup.microphone,
      ],
    );
  }
}


String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }
  // We want to round up the remaining time to the nearest second
  d += Duration(microseconds: 999999);
  return "${f(d.inDays)}day : ${f(d.inHours%24)}h : ${f(d.inMinutes%60)}min : ${f(d.inSeconds%60)}s";
}

