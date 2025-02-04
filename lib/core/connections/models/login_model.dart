import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  late String email;
  late String password;

  LoginModel({required this.email, required this.password});

  // JSON'dan nesne oluşturma
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  // Nesneyi JSON'a çevirme
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

