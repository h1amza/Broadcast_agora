import 'package:flutter/material.dart';
import 'package:flutter_app_agora/Model/ModelBroadcast.dart';
import 'package:flutter_app_agora/Style/colorStyle.dart';
import 'package:flutter_app_agora/services/jsonApiBroadcast.dart';
import 'NewBroadcast.dart';
import 'customCardModel.dart';


class AddBroadcast extends StatefulWidget {
  @override
  _AddBroadcastState createState() => _AddBroadcastState();
}

class _AddBroadcastState extends State<AddBroadcast> {
  bool a=false,b=false,c=false;

  double height1,height2,height3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: AppColors.colorPrincipal1,size: 35,),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              ModelBroadCast modelBroadCast;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewBradcast(modelBroadCast)));
            },
            icon: Icon(Icons.add_box,color: AppColors.colorPrincipal1,size: 35,),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(right: 25,left: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                animation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class animation extends StatefulWidget {
  @override
  _animationState createState() => _animationState();
}

class _animationState extends State<animation> {
  bool a=false,b=false,c=false;
  double height1 = 200;
  double height2 = 200;
  double height3 = 200;
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(alignment: Alignment.bottomLeft,
                  child: Text('Finished Broadcast',style: TextStyle(color: AppColors.colorPrincipal1,fontSize: 25,fontWeight: FontWeight.bold),)),
              IconButton(
                onPressed: (){
                  setState(() {
                    a = !a;
                    if(a){
                      height1 = 500;
                    }
                    else height1 = MediaQuery.of(context).size.height/4.8;
                  });
                },
                icon: Icon(!a?Icons.add:Icons.close,color: AppColors.colorPrincipal1,),
              )
            ],
          ),
          SizedBox(height: 5,),
          AnimatedContainer(
              height: height1,
              duration: Duration(milliseconds: 500),
              child:FutureBuilder(
                future: JsonApiBrodCast.allBroadCastUser(),
                builder: (context,snapshot){
                  return CustomCardWidget(ModelBroadCast.lMBCUFinished,'3');
                },
              )
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(alignment: Alignment.bottomLeft,
                  child: Text('Future Broadcast Accepted',style: TextStyle(color: AppColors.colorPrincipal1,fontSize: 25,fontWeight: FontWeight.bold),)),
              IconButton(
                onPressed: (){
                  setState(() {
                    b = !b;
                    if(b){
                      height2 = 500;
                    }
                    else height2 = MediaQuery.of(context).size.height/4.8;
                  });
                },
                icon: Icon(!b?Icons.add:Icons.close,color: AppColors.colorPrincipal1,),
              )
            ],
          ),
          SizedBox(height: 5,),
          AnimatedContainer(
              height: height2,
              duration: Duration(milliseconds: 500),
              child:FutureBuilder(
                future: JsonApiBrodCast.allBroadCastUser(),
                builder: (context,snapshot){
                  return CustomCardWidget(ModelBroadCast.lMBCUFAccepted,'2');
                },
              )
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(alignment: Alignment.bottomLeft,
                  child: Text('Future Broadcast',style: TextStyle(color: AppColors.colorPrincipal1,fontSize: 25,fontWeight: FontWeight.bold),)),
              IconButton(
                onPressed: (){
                  setState(() {
                    c = !c;
                    if(c){
                      height3 = 500;
                    }
                    else height3=MediaQuery.of(context).size.height/4.8;
                  });
                },
                icon: Icon(!c?Icons.add:Icons.close,color: AppColors.colorPrincipal1,),
              )
            ],
          ),
          SizedBox(height: 5,),
          AnimatedContainer(
              height: height3,
              duration: Duration(milliseconds: 500),
              child:FutureBuilder(
                future: JsonApiBrodCast.allBroadCastUser(),
                builder: (context,snapshot){
                  return CustomCardWidget(ModelBroadCast.lMBCUFuture,'1');
                },
              )
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}


