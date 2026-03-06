class SignupResultEntity {
  final String message;
  final String? token;

  SignupResultEntity({required this.message, this.token});

  @override
  String toString() => 'SignupResultEntity(message: $message, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignupResultEntity &&
        other.message == message &&
        other.token == token;
  }

  @override
  int get hashCode => message.hashCode ^ token.hashCode;
}
