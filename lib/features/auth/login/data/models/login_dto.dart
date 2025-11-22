import 'user_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_dto.g.dart';

LoginDto loginDtoFromJson(String str) => LoginDto.fromJson(json.decode(str));

String loginDtoToJson(LoginDto data) => json.encode(data.toJson());

@JsonSerializable()
class LoginDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "user")
  UserDto? userdto;

  LoginDto({this.message, this.token, this.userdto});

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
