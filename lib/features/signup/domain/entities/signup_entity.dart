class SignupEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;
  final String userName;

  SignupEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.userName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupEntity &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.password == password &&
        other.rePassword == rePassword &&
        other.phone == phone &&
        other.userName == userName;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        rePassword.hashCode ^
        phone.hashCode ^
        userName.hashCode;
  }
}
