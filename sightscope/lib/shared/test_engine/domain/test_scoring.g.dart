// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_scoring.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestScoring _$TestScoringFromJson(Map<String, dynamic> json) => _TestScoring(
  accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0,
  score: (json['score'] as num?)?.toDouble() ?? 0,
  meanReactionTimeMs: (json['meanReactionTimeMs'] as num?)?.toDouble() ?? 0,
  metrics:
      json['metrics'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  n: (json['n'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TestScoringToJson(_TestScoring instance) =>
    <String, dynamic>{
      'accuracy': instance.accuracy,
      'score': instance.score,
      'meanReactionTimeMs': instance.meanReactionTimeMs,
      'metrics': instance.metrics,
      'n': instance.n,
    };
