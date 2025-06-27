import 'package:json_annotation/json_annotation.dart';
part 'response_register_model.g.dart';

@JsonSerializable()
class ResponseRegisterModel {
  String? message;

  ResponseRegisterModel({
    this.message,
  });

  factory ResponseRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRegisterModelToJson(this);
}
