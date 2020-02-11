import 'package:flutter/material.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              firstPosition(context),
              secondPosition(context),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(right: 25,left: 25),
                child: buttonForm(context,'Submit'),
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstPosition(context){
    return Container(
      height: 340,
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
                Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 140,
                          child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0ZkkrMC61AitP3kS2jymxi5bUUCEAzNQX1EILAyA9SufNhH-9bg&s')
                      ),
                      Text('Chat With Customer Service',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),)
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width*0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 0.5),
                          blurRadius: 10,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15,left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: Image.network('https://i.pinimg.com/originals/41/28/2b/41282b58cf85ddaf5d28df96ed91de98.png'),
                        ),
                        Container(
                          height: 60,
                          child: Image.network('https://icons-for-free.com/iconfiles/png/512/color+google+media+network+social+icon-1320086080668511532.png'),
                        ),
                        Container(
                          height: 60,
                          child: Image.network('https://i.imgyukle.com/2019/02/26/lX3Iv.png'),
                        ),
                        Container(
                          height: 60,
                          child: Image.network('https://cdn3.iconfinder.com/data/icons/free-social-icons/67/twitter_circle_color-512.png'),
                        ),
                      ],
                    ),
                  )
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
      height: 300,
      width: MediaQuery.of(context).size.width*0.98                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(right: 25,left: 25),
          child: TextField(
            controller: message,
            keyboardType: TextInputType.multiline,
            maxLines: 12,
            maxLength: 300,
            decoration: InputDecoration(
                hintText: 'Message',
            ),
          ),
        ),
      ),
    );
  }

}
