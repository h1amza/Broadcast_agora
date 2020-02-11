
class ModelUser{

  String token;
  String id;
  String role;
  String firsName;
  String lastName;
  String userName;
  String email;

  ModelUser({this.token,this.id,this.role,this.firsName,this.lastName,this.userName,this.email});

  static ModelUser newUser = ModelUser();
}