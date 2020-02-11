import 'package:flutter_app_agora/Model/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class JsonApiLogin{
//-------------------------------------------------------------------------
  static Future<String> signUp(String user,String l,String f,String email,String pass,int sex) async {
    String url='https://bakarbakar.herokuapp.com/auth/signup';
    Map<String,String> he={"content-type": "application/json"};
    String bodyJson =
        '{"userName":"$user","firstName":"$f","lastName":"$l","email":"$email","password":"$pass","sexe": $sex}';

    http.Response r = await http.post('$url', headers: he, body: bodyJson);

    var data = jsonDecode(r.body);
    bool t = data['success'];
    if(t){
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('code', data["body"]['code'].toString());
      prefs.setString('id', data["body"]['user']['_id'].toString());
      return 'true';
    }
    else return '${data['body']['message']}';
  }
//-------------------------------------------------------------------------
  static Future<String> signIn(String em,String pass) async {
    print(em);
    print(pass);
    String url='https://bakarbakar.herokuapp.com/auth/login';
    Map<String,String> he={"content-type": "application/json"};
    String bodyJson = '{"email": "$em","password": "$pass"}';
    http.Response r = await http.post('$url', headers: he, body: bodyJson);

    var data = jsonDecode(r.body);
    print(data);
    bool t = data['success'];
    final prefs = await SharedPreferences.getInstance();
    if(t){
      prefs.setString('token',data['body']['token'].toString());
      ModelUser.newUser.token = '${data['body']['token'].toString()}';
      ModelUser.newUser.id='${data['body']['user']['_id'].toString()}';
      ModelUser.newUser.role = '${data['body']['user']['accountType'].toString()}';
      ModelUser.newUser.firsName = '${data['body']['user']['firstName'].toString()}';
      ModelUser.newUser.lastName = '${data['body']['user']['lastName'].toString()}';
      ModelUser.newUser.userName = '${data['body']['user']['userName'].toString()}';
      ModelUser.newUser.email = '${data['body']['user']['email'].toString()}';
      return 'true';
    }
    else{
      if(data['body']['key'] == 'verify'){
        prefs.setString('code', data["body"]['code'].toString());
        prefs.setString('id', data["body"]['userId'].toString());
        return "false1";
      }
      else return  data["body"]['message'];
    }
  }
//-------------------------------------------------------------------------
  static Future<bool> validCode() async {
    String url = 'https://bakarbakar.herokuapp.com/auth/verify-account';
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');
    Map<String,String> he={"Content-type": "application/json"};
    String json = '{"id": "$id"}';

    http.Response r = await http.post('$url', headers: he, body: json);

    var data = jsonDecode(r.body);
    bool t = data['success'];

    if(!t){
      return false;
    }
    else{
      prefs.setString('token',data['token'].toString());
      ModelUser.newUser.token = '${data['token'].toString()}';
      ModelUser.newUser.id='${data['user']['_id'].toString()}';
      ModelUser.newUser.role = '${data['user']['accountType'].toString()}';
      ModelUser.newUser.firsName = '${data['user']['firstName'].toString()}';
      ModelUser.newUser.lastName = '${data['user']['lastName'].toString()}';
      ModelUser.newUser.userName = '${data['user']['userName'].toString()}';
      ModelUser.newUser.email = '${data['user']['email'].toString()}';
      return true;
    }
  }
//-------------------------------------------------------------------------
  static Future<String> forgotPassword(String em) async {
    String url = 'https://bakarbakar.herokuapp.com/auth/reset-password';
    Map<String,String> he={"Content-type": "application/json"};
    String json = '{"email": "$em"}';

    http.Response r = await http.post('$url', headers: he, body: json);

    var data = jsonDecode(r.body);
    bool t = data['success'];

    if(!t){
      return data['body']['message'];
    }
    else{
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('code', data["body"]['code'].toString());
      prefs.setString('id', data["body"]['user']['_id'].toString());
      return 'true';
    }
  }
  //-------------------------------------------------------------------------
  static Future<String> changePassword(String pass) async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');

    String url = 'https://bakarbakar.herokuapp.com/auth/change-password';
    Map<String,String> he={"Content-type": "application/json"};
    String json = '{"id": "$id","password":"$pass"}';

    http.Response r = await http.post('$url', headers: he, body: json);

    var data = jsonDecode(r.body);
    bool t = data['success'];

    if(!t){
      return data['body']['message'];
    }
    else{
      prefs.setString('token',data['token'].toString());
      ModelUser.newUser.token = '${data['token'].toString()}';
      ModelUser.newUser.id='${data['user']['_id'].toString()}';
      ModelUser.newUser.role = '${data['user']['accountType'].toString()}';
      ModelUser.newUser.firsName = '${data['user']['firstName'].toString()}';
      ModelUser.newUser.lastName = '${data['user']['lastName'].toString()}';
      ModelUser.newUser.userName = '${data['user']['userName'].toString()}';
      ModelUser.newUser.email = '${data['user']['email'].toString()}';
      return 'true';
    }
  }
//-------------------------------------------------------------------------
  static Future<String> checkToken() async {

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if(token == ''|| token == null)
      return 'false';
    String url = 'https://bakarbakar.herokuapp.com/user/now';
    Map<String,String> he={"Content-type": "application/json",'authorization':'$token'};

    http.Response r = await http.get('$url', headers: he);
    var data = jsonDecode(r.body);
    bool t = data['success'];
    if(t){
      if(data['user'].isNotEmpty)
      if(data['user']['verify'] == true){
        ModelUser.newUser.token = '$token';
        ModelUser.newUser.id='${data['user']['_id'].toString()}';
        ModelUser.newUser.role = '${data['user']['accountType'].toString()}';
        ModelUser.newUser.firsName = '${data['user']['firstName'].toString()}';
        ModelUser.newUser.lastName = '${data['user']['lastName'].toString()}';
        ModelUser.newUser.userName = '${data['user']['userName'].toString()}';
        ModelUser.newUser.email = '${data['user']['email'].toString()}';
        return 'true';
      }
      return 'false';
    }
    return 'false';
  }
}