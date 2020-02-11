import 'dart:io';

class ModelBroadCast{

  String id;
  String title;
  String description;
  List collaboration;
  DateTime date;
  File image;
  String photo;
  bool recorded;
  String urlRecord;
  bool accepted;
  bool finished;
  String idUser;

  ModelBroadCast({this.id,this.idUser,this.title,this.description,this.collaboration,this.date,this.image,this.photo,this.recorded,this.urlRecord,this.accepted,this.finished});

  static List<ModelBroadCast> listModelBroadCast = List<ModelBroadCast>();

  static List<ModelBroadCast> listModelBroadCastFuture = List<ModelBroadCast>();

  static List<ModelBroadCast> lMBCUFuture = List<ModelBroadCast>();

  static List<ModelBroadCast> lMBCUFAccepted = List<ModelBroadCast>();

  static List<ModelBroadCast> lMBCUFinished = List<ModelBroadCast>();

  static Future<String> refresh(){
    ModelBroadCast.lMBCUFinished.clear();
    ModelBroadCast.lMBCUFAccepted.clear();
    ModelBroadCast.lMBCUFuture.clear();
  }
}