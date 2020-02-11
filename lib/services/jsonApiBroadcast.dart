import 'package:flutter_app_agora/Model/ModelBroadcast.dart';
import 'package:flutter_app_agora/Model/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

class JsonApiBrodCast{
//-------------------------------------------------------------------------
  static String filTraTioN(data,int src){

    if(data['podcasts'].isNotEmpty){

      var id,photo,title,desc,date,recorded,accepted,finishid, user;
      ModelBroadCast modelBroadCast;

      fetchdata(int i){
         id = data['podcasts'][i]['_id'];
         photo = "${data['podcasts'][i]['photo']}";
         title = data['podcasts'][i]['title'];
         desc = data['podcasts'][i]['description'];
         date = data['podcasts'][i]['date'];
         recorded = data['podcasts'][i]['recorded'];
         accepted = data['podcasts'][i]['accepted'];
         finishid = data['podcasts'][i]['finishid'];
         user = data['podcasts'][i]['user'];
         modelBroadCast = null;
         //print(photo);
         modelBroadCast = ModelBroadCast(
             id:id,
             photo: photo,
             title: title,
             description: desc,
             date: DateTime.parse(date),
             recorded: recorded,
             accepted: accepted,
             finished: finishid,
             idUser: user
         );
      }

      if(src == 0){
        ModelBroadCast.listModelBroadCast.clear();
        for(int i=0;i<data['podcasts'].length;i++){
          fetchdata(i);
          if(modelBroadCast.accepted && !modelBroadCast.finished)
          ModelBroadCast.listModelBroadCast.add(modelBroadCast);
        }
      }

      if(src==3){
        ModelBroadCast.lMBCUFinished.clear();
        ModelBroadCast.lMBCUFAccepted.clear();
        ModelBroadCast.lMBCUFuture.clear();
        for(int i=0;i<data['podcasts'].length;i++){
          id = data['podcasts'][i]['_id'];
          photo = "${data['podcasts'][i]['photo']}";
          title = data['podcasts'][i]['title'];
          desc = data['podcasts'][i]['description'];
          date = data['podcasts'][i]['date'];
          recorded = data['podcasts'][i]['recorded'];
          accepted = data['podcasts'][i]['accepted'];
          finishid = data['podcasts'][i]['finishid'];
          user = data['podcasts'][i]['user']['_id'];
          //print(photo);
          modelBroadCast = ModelBroadCast(
              id:id,
              photo: photo,
              title: title,
              description: desc,
              date: DateTime.parse(date),
              recorded: recorded,
              accepted: accepted,
              finished: finishid,
              idUser: user
          );
          if(accepted && !finishid)
            ModelBroadCast.lMBCUFAccepted.add(modelBroadCast);

          if(!accepted && !finishid)
            ModelBroadCast.lMBCUFuture.add(modelBroadCast);

          if(finishid)
            ModelBroadCast.lMBCUFinished.add(modelBroadCast);
        }
      }

      if(src == 2){
        ModelBroadCast.listModelBroadCastFuture.clear();
        for(int i=0;i<data['podcasts'].length;i++){
          fetchdata(i);
          if(modelBroadCast.finished)
          ModelBroadCast.listModelBroadCastFuture.add(modelBroadCast);

        }
      }

      return 'true';
    }
    else return 'notTrue';
  }
//-------------------------------------------------------------------------
  static Future<String> allAcceptBroadCast() async {

    var uri = Uri.parse("https://bakarbakar.herokuapp.com/podcast");
    Map<String,String> he={"Content-type": "application/json",'authorization': "${ModelUser.newUser.token}"};

    final request = new http.MultipartRequest("GET", uri);
    request.headers.addAll(he);

    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == 200){
      var response = await http.Response.fromStream(streamedResponse);
      var data = jsonDecode(response.body);
      //print(data);
      if(data['success']){
        String res = filTraTioN(data,0);
        return res;
      }
      else return 'false';
    }
    else return 'false';
  }
//-------------------------------------------------------------------------
  static Future<String> allBroadCastFinished() async {

    var uri = Uri.parse("https://bakarbakar.herokuapp.com/podcast");
    Map<String,String> he={"Content-type": "application/json",'authorization': "${ModelUser.newUser.token}"};

    final request = new http.MultipartRequest("GET", uri);
    request.headers.addAll(he);

    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == 200){
      var response = await http.Response.fromStream(streamedResponse);
      var data = jsonDecode(response.body);
      //print(data);
      if(data['success']){
        String res = filTraTioN(data,2);
        return res;
      }
      else return 'false';
    }
    else return 'false';
  }
//-------------------------------------------------------------------------
  static Future<String> allBroadCastUser() async {

    var uri = Uri.parse("https://bakarbakar.herokuapp.com/podcast/user");
    Map<String,String> he={"Content-type": "application/json",'authorization': "${ModelUser.newUser.token}"};

    final request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(he);

    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == 200){
      var response = await http.Response.fromStream(streamedResponse);
      var data = jsonDecode(response.body);
      if(data['success']){
        String res = filTraTioN(data,3);
        return res;
      }
      else return 'false';
    }
    else return 'false';
  }
//-------------------------------------------------------------------------
   static Future<String> allBroadCastFilTre(String id) async {

    String url = 'https://bakarbakar.herokuapp.com/podcast/:$id';
    Map<String,String> he={"Content-type": "application/json",'authorization':'${ModelUser.newUser.token}'};

    http.Response r = await http.get('$url', headers: he);
    var data = jsonDecode(r.body);
    print(data);

    return '';
  }
//-------------------------------------------------------------------------
  static Future<String> createBroadCast(ModelBroadCast modelBroadCast) async {
    var uri = Uri.parse("https://bakarbakar.herokuapp.com/podcast");
    Map<String,String> he={"Content-type": "application/json",'authorization': "${ModelUser.newUser.token}"};

    try{
      final request = new http.MultipartRequest("POST", uri);
      request.headers.addAll(he);
      request.fields['title'] = modelBroadCast.title;
      request.fields['description'] = modelBroadCast.description;
      request.fields['date'] = '${modelBroadCast.date}';
      request.fields['recorded'] = "${modelBroadCast.recorded}";
      //request.fields['comperationUsers'] = modelBroadCast.collaboration;

      if(modelBroadCast.image != null) {
        var lent = modelBroadCast.image.length();
        request.files.add(
          http.MultipartFile(
              'photo',
              modelBroadCast.image.openRead(),
              await lent,
              filename: basename(modelBroadCast.image.path)
          ),
        );
      }
      var streamedResponse = await request.send();
      if(streamedResponse.statusCode == 200){
        var response = await http.Response.fromStream(streamedResponse);
        var data = jsonDecode(response.body);
        print(data);
        if(data['success']){
          return 'true';
        }
        else return 'erreur';
      }
      else return 'erreur';
    }
    catch(e){
      print('erreur:$e');
    }
  }
//-------------------------------------------------------------------------
  static Future<String> updateBroadCast(ModelBroadCast modelBroadCast) async {
    print(modelBroadCast.id);
    var uri = Uri.parse("https://bakarbakar.herokuapp.com/podcast/${modelBroadCast.id}");
    Map<String,String> he={"Content-type": "application/json",'authorization': "${ModelUser.newUser.token}"};
    try{
      final request = new http.MultipartRequest("PUT", uri);
      request.headers.addAll(he);
      request.fields['title'] = modelBroadCast.title;
      request.fields['description'] = modelBroadCast.description;
      request.fields['date'] = '${modelBroadCast.date}';
      request.fields['recorded'] = "${modelBroadCast.recorded}";
      //request.fields['comperationUsers'] = modelBroadCast.collaboration;

      if(modelBroadCast.image != null) {
        var lent = modelBroadCast.image.length();
        request.files.add(
          http.MultipartFile(
              'photo',
              modelBroadCast.image.openRead(),
              await lent,
              filename: basename(modelBroadCast.image.path)
          ),
        );
      }
      var streamedResponse = await request.send();
      if(streamedResponse.statusCode == 200){
        var response = await http.Response.fromStream(streamedResponse);
        var data = jsonDecode(response.body);
        print(data);
        if(data['success']){
          return 'true';
        }
        else return 'erreur';
      }
      else return 'erreur';
    }
    catch(e){
      print('erreur:$e');
    }
  }
//-------------------------------------------------------------------------
  static Future<String> deleteBroadCast(String id) async {

    String url = 'https://bakarbakar.herokuapp.com/podcast/$id';
    Map<String,String> he={"Content-type": "application/json",'authorization':'${ModelUser.newUser.token}'};

    http.Response r = await http.delete('$url', headers: he);
    var data = jsonDecode(r.body);
    //print(data);
    bool t = data['success'];
    if(t){
      return 'true';
    }
    else return 'false';
  }
//-------------------------------------------------------------------------
  static Future<String> startBroadCast(String id) async {
    String url = 'https://bakarbakar.herokuapp.com/podcast/start/$id';
    Map<String,String> he={"Content-type":"application/json",'authorization':"${ModelUser.newUser.token}"};

    http.Response r = await http.get('$url', headers: he);

    var data = jsonDecode(r.body);
    bool t = data['success'];
    if(!t){
      return 'false';
    }
    else{
      if(data['podcast']['start']){
       return 'true';
      }
      else return 'false';
    }
  }
//-------------------------------------------------------------------------
  static Future<String> timeBroadCast(String id) async {
    String url = 'https://bakarbakar.herokuapp.com/podcast/date/$id';
    Map<String,String> he={"Content-type":"application/json",'authorization':"${ModelUser.newUser.token}"};

    http.Response r = await http.get('$url', headers: he);

    var data = jsonDecode(r.body);

    int d = data['date'];
    return '$d';

  }
}