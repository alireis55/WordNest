// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestLoginModel _$RequestLoginModelFromJson(Map<String, dynamic> json) =>
    RequestLoginModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RequestLoginModelToJson(RequestLoginModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
