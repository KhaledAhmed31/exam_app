class ResetPasswordResponse {
  String? message;
  String? token;

  ResetPasswordResponse({this.message, this.token});

  ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
  }
}
