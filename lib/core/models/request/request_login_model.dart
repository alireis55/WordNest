import 'package:json_annotation/json_annotation.dart';
part 'request_login_model.g.dart';

@JsonSerializable()
class RequestLoginModel {
  String? email;
  String? password;

  RequestLoginModel({
    this.email,
    this.password,
  });

  factory RequestLoginModel.fromJson(Map<String, dynamic> json) =>
      _$RequestLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLoginModelToJson(this);
}
