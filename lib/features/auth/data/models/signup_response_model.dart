class SignupResponseModel {
  final String? message;
  final String? token;
  final UserData? user;
  final String? error;

  SignupResponseModel({this.message, this.token, this.user, this.error});

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': user?.toJson(),
      'error': error,
    };
  }
}

class UserData {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final int? grade;
  final String role;
  final String? profileImage;
  final DateTime? createdAt;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    this.grade,
    required this.role,
    this.profileImage,
    this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      grade: json['grade'],
      role: json['role'],
      profileImage: json['profileImage'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'grade': grade,
      'role': role,
      'profileImage': profileImage,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
