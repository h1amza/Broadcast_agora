import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_agora/AppScreen/NewBroadcast.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:flutter_app_agora/Model/ModelBroadcast.dart';
import 'package:flutter_app_agora/Style/colorStyle.dart';
import 'package:flutter_app_agora/services/jsonApiBroadcast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';
import 'detailBroadCastScreen.dart';

customCard(List<ModelBroadCast> list,int i){
  List<ModelBroadCast> l = list;
  if(l.length != 0){
    return ListView.builder(
      itemCount: i == 3 ? 3 : l.length,
      itemBuilder: (context,index){
        return containerContent(l[index],context);
      },
    );
  }
  else{
    return Center(child: Text("Noting to show",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),));
  }
}

class CustomCardWidget extends StatefulWidget {
  List<ModelBroadCast> list;
  String desc;
  CustomCardWidget(this.list,this.desc);
  @override
  _CustomCardWidgetState createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  List<ModelBroadCast> l;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    l=widget.list;
  }
  @override
  Widget build(BuildContext context) {
    if(l.length != 0){
      return Container(
        child: ListView.builder(
          itemCount: l.length,
          itemBuilder: (context,index){
            return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.3,
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Update',
                    color: Colors.indigo,
                    icon: Icons.update,
                    onTap: (){
                      ModelBroadCast modelBroadCast=ModelBroadCast();
                      modelBroadCast.id=l[index].id;
                      modelBroadCast.photo=l[index].photo;
                      modelBroadCast.title=l[index].title;
                      modelBroadCast.description=l[index].description;
                      modelBroadCast.date=l[index].date;
                      modelBroadCast.recorded=l[index].recorded;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewBradcast(modelBroadCast)));
                    },
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: ()async{
                      ProgressDialog pr =prDialog(context);
                      pr.show();
                      String t = await JsonApiBrodCast.deleteBroadCast(l[index].id);
                      if(t=='true'){
                        if(widget.desc=='1'){
                          setState((){
                            ModelBroadCast.lMBCUFuture.remove(l[index]);
                          });
                        }
                        if(widget.desc=='2'){
                          setState((){
                            ModelBroadCast.lMBCUFAccepted.remove(l[index]);
                          });
                        }
                        if(widget.desc=='3'){
                          setState((){
                            ModelBroadCast.lMBCUFinished.remove(l[index]);
                          });
                        }
                      }
                      else {
                        flushBarShow(context,'erreur');
                      }
                      pr.hide();
                    },
                  ),
                ],
                child: containerContent(l[index],context)
            );
          },
        ),
      );
    }
    else{
      return Center(child: Text("Noting to show",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),));
    }
  }
}

//customCardUser(List<ModelBroadCast> list){
//  List<ModelBroadCast> l = list;
//}
containerContent(ModelBroadCast l,context){
  return InkWell(
    onTap: ()async{
      ProgressDialog pr = prDialog(context);
      pr.show();
      var r = await JsonApiBrodCast.timeBroadCast(l.id);
      pr.hide();
      if(r!='false'){
        DateTime d= DateTime.fromMillisecondsSinceEpoch(int.parse(r));
        Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailBroadCast(l,d)));
      }
    },
    child: Container(
      height: 150,
      child: Card(
        elevation: 7,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: l.photo==''?Image.network(
                  'https://picsum.photos/250?image=9',
                ):CachedNetworkImage(
                  imageUrl: "https://bakarbakar.herokuapp.com/images/${l.photo}",
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Text("${l.title}",style: TextStyle(color:  AppColors.colorPrincipal1,fontSize: 22),),
                    ),
                    SizedBox(height: 2,),
                    Flexible(
                        child: Align(
                          alignment: Alignment.centerLeft,
                            child: Text("${l.description}",maxLines: 2),
                        )
                    ),
                    SizedBox(height: 2,),
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("${DateFormat.yMMMd().format(l.date)} / ${DateFormat.Hm().format(l.date)}",style: TextStyle(color: Colors.green[700]),)
                          //Text("${l.date.year}-${l.date.month}-${l.date.day} ${l.date.hour}h${l.date.minute}")
                        ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}