// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestResponse _$TestResponseFromJson(Map<String, dynamic> json) =>
    _TestResponse(
      stimulus: TestStimulus.fromJson(json['stimulus'] as Map<String, dynamic>),
      answer: json['answer'] as Map<String, dynamic>,
      correct: json['correct'] as bool? ?? false,
      durationMillis: (json['durationMillis'] as num?)?.toInt() ?? 0,
      recordedAtEpochMs: (json['recordedAtEpochMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TestResponseToJson(_TestResponse instance) =>
    <String, dynamic>{
      'stimulus': instance.stimulus,
      'answer': instance.answer,
      'correct': instance.correct,
      'durationMillis': instance.durationMillis,
      'recordedAtEpochMs': instance.recordedAtEpochMs,
    };
