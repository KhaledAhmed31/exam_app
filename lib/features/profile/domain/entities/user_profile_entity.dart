import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? profilePic;
  final bool isVerified;

  const UserProfileEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.profilePic,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstName,
    lastName,
    email,
    phone,
    profilePic,
    isVerified,
  ];

  String get fullName => '$firstName $lastName';
}
