class LoginModel {
  String? email;
  String? password;
  String? token;
  UserModel? userModel;
  LoginModel({this.email, this.password, this.token, this.userModel});
}

class UserModel {
  String? firstName;
  String? lastName;
  String? id;
  UserModel({this.firstName, this.lastName, this.id});
}
