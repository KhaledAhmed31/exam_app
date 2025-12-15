import 'package:exam_app/features/auth/domain/models/signup_entity.dart';

class SignupRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;
  final String username;

  SignupRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'rePassword': rePassword,
      'phone': phone,
    };
  }

  factory SignupRequestModel.fromEntity(SignupEntity entity) {
    return SignupRequestModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      rePassword: entity.rePassword,
      phone: entity.phone,
      username: entity.userName,
    );
  }

  factory SignupRequestModel.fromJson(Map<String, dynamic> json) {
    return SignupRequestModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      rePassword: json['rePassword'],
      phone: json['phone'],
      username: json['username'],
    );
  }
}
