import 'package:flutter/material.dart';
import 'package:flutter_app_agora/AppScreen/drawerScreen.dart';
import 'package:flutter_app_agora/Model/ModelBroadcast.dart';
import 'package:flutter_app_agora/Model/userModel.dart';
import 'package:flutter_app_agora/Style/colorStyle.dart';
import 'package:flutter_app_agora/services/jsonApiBroadcast.dart';

import 'customCardModel.dart';
import 'dashboard.dart';
import 'futureBroadcast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              firstPosition(context),
              secondPosition(context),SizedBox(height: 15,),
              thirdPosition(context),SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstPosition(context){
    return Container(
        height: 380,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(ModelUser.newUser.userName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                            Text(ModelUser.newUser.email,style: TextStyle(color: Colors.white,fontSize: 12),),
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                      IconButton(
                        onPressed: (){
                          var sc = GlobalKey<ScaffoldState>();
                          sc = _scaffoldKey;
                          sc.currentState.openDrawer();
                        },
                        icon: Icon(Icons.menu,color: Colors.white,size: 25,),
                      ),

                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 0.5),
                            blurRadius: 10,
                          )
                        ]),
                    child: Image.network('https://cdn.clipart.email/27c8e40b5d63fc1a7eb16df12dfacc73_royalty-free-clipart-image-news-broadcasting-microphone_350-316.png'),
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
      padding: const EdgeInsets.only(left: 25,right: 25),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Top Listener',style: TextStyle(color: AppColors.colorPrincipal1,fontSize: 25,fontWeight: FontWeight.bold),),
                Text('More',style: TextStyle(color:  AppColors.colorPrincipal1,fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return  Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.purple,
                                  child: Icon(Icons.person,color: Colors.white,),
                                ),
                                Text('Name',style: TextStyle(color: AppColors.colorPrincipal2,fontSize: 18),),
                              ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget thirdPosition(context){
    return Padding(
      padding: const EdgeInsets.only(left: 25,right: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Featured broadcast',style: TextStyle(color:  AppColors.colorPrincipal1,fontSize: 25,fontWeight: FontWeight.bold),),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen(2)));
                    },
                    child: Text('More',style: TextStyle(color:  AppColors.colorPrincipal1,fontSize: 18),)
                ),
              ],
            ),
            Container(
              height: 350,
              child: FutureBuilder(
                future: JsonApiBrodCast.allAcceptBroadCast(),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return Icon(Icons.error,size: 28,);
                    }
                    else return customCard(ModelBroadCast.listModelBroadCast,3);
                  }
                  else return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

