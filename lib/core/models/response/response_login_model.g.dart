// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLoginModel _$ResponseLoginModelFromJson(Map<String, dynamic> json) =>
    ResponseLoginModel(
      token: json['token'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResponseLoginModelToJson(ResponseLoginModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'message': instance.message,
    };
