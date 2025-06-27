import 'package:json_annotation/json_annotation.dart';
part 'response_random_word_model.g.dart';

@JsonSerializable()
class ResponseRandomWordModel {
  String? message;
  Word? word;

  ResponseRandomWordModel({
    this.message,
    this.word,
  });

  factory ResponseRandomWordModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseRandomWordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRandomWordModelToJson(this);
}

@JsonSerializable()
class Word {
  String? id;
  String? word;
  String? meaning;
  String? pronunciation;
  String? example;
  String? level;

  Word({
    this.id,
    this.word,
    this.meaning,
    this.pronunciation,
    this.example,
    this.level,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);
}
