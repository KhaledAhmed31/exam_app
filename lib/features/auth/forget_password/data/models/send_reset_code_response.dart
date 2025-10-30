import 'package:json_annotation/json_annotation.dart';

part 'send_reset_code_response.g.dart';
@JsonSerializable()
class SendResetCodeResponse {
  String? message;
  String? info;

  SendResetCodeResponse({this.message, this.info});

 factory SendResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SendResetCodeResponseFromJson(json);
}
