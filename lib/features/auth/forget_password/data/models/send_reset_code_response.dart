class SendResetCodeResponse {
  String? message;
  String? info;

  SendResetCodeResponse({this.message, this.info});
  SendResetCodeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'];
  }
}
