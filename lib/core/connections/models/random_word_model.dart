import 'package:json_annotation/json_annotation.dart';

part 'random_word_model.g.dart';

@JsonSerializable()
class WordModel {
  @JsonKey(name: "_id")
  final String id;
  final String word;
  final String meaning;
  final String pronunciation;
  final String example;
  final String level;

  WordModel({
    required this.id,
    required this.word,
    required this.meaning,
    required this.pronunciation,
    required this.example,
    required this.level,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) =>
      _$WordModelFromJson(json);

  Map<String, dynamic> toJson() => _$WordModelToJson(this);
}

@JsonSerializable()
class RandomWordModel {
  final String message;
  final WordModel word;

  RandomWordModel({required this.message, required this.word});

  factory RandomWordModel.fromJson(Map<String, dynamic> json) =>
      _$RandomWordModelFromJson(json);

  Map<String, dynamic> toJson() => _$RandomWordModelToJson(this);
}
