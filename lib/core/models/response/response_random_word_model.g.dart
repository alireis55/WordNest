// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_random_word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRandomWordModel _$ResponseRandomWordModelFromJson(
        Map<String, dynamic> json) =>
    ResponseRandomWordModel(
      message: json['message'] as String?,
      word: json['word'] == null
          ? null
          : Word.fromJson(json['word'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseRandomWordModelToJson(
        ResponseRandomWordModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'word': instance.word,
    };

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      id: json['id'] as String?,
      word: json['word'] as String?,
      meaning: json['meaning'] as String?,
      pronunciation: json['pronunciation'] as String?,
      example: json['example'] as String?,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'meaning': instance.meaning,
      'pronunciation': instance.pronunciation,
      'example': instance.example,
      'level': instance.level,
    };
