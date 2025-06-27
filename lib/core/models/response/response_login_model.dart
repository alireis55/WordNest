import 'package:json_annotation/json_annotation.dart';
part 'response_login_model.g.dart';

@JsonSerializable()
class ResponseLoginModel {
  String? token;
  String? message;

  ResponseLoginModel({
    this.token,
    this.message,
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginModelToJson(this);
}
