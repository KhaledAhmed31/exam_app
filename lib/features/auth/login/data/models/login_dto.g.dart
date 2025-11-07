// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) => LoginDto(
  message: json['message'] as String?,
  token: json['token'] as String?,
  userdto: json['user'] == null
      ? null
      : UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginDtoToJson(LoginDto instance) => <String, dynamic>{
  'message': instance.message,
  'token': instance.token,
  'user': instance.userdto,
};
