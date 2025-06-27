import 'package:json_annotation/json_annotation.dart';
part 'request_register_model.g.dart';

@JsonSerializable()
class RequestRegisterModel {
  String? username;
  String? email;
  String? password;

  RequestRegisterModel({
    this.username,
    this.email,
    this.password,
  });

  factory RequestRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RequestRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestRegisterModelToJson(this);
}
