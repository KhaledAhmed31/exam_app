class VerifyResetCodeResponse {
  String? status;
  VerifyResetCodeResponse({this.status});

  VerifyResetCodeResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
  }
}
