// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
      id: json['_id'] as String,
      word: json['word'] as String,
      meaning: json['meaning'] as String,
      pronunciation: json['pronunciation'] as String,
      example: json['example'] as String,
      level: json['level'] as String,
    );

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
      '_id': instance.id,
      'word': instance.word,
      'meaning': instance.meaning,
      'pronunciation': instance.pronunciation,
      'example': instance.example,
      'level': instance.level,
    };

RandomWordModel _$RandomWordModelFromJson(Map<String, dynamic> json) =>
    RandomWordModel(
      message: json['message'] as String,
      word: WordModel.fromJson(json['word'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RandomWordModelToJson(RandomWordModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'word': instance.word,
    };
