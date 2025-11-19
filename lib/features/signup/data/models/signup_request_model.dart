import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';

class SignupRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String userName;
  // Removed gender and grade to match simplified entity

  SignupRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.userName,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'userName': userName,
    };
  }

  factory SignupRequestModel.fromEntity(SignupEntity entity) {
    return SignupRequestModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      phone: entity.phone,
      userName: entity.userName,
    );
  }

  factory SignupRequestModel.fromJson(Map<String, dynamic> json) {
    return SignupRequestModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      userName: json['userName'],
    );
  }
}