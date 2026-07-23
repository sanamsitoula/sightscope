// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_confidence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestConfidence _$TestConfidenceFromJson(Map<String, dynamic> json) =>
    _TestConfidence(
      level:
          $enumDecodeNullable(_$ConfidenceLevelEnumMap, json['level']) ??
          ConfidenceLevel.medium,
      score: (json['score'] as num?)?.toDouble() ?? 0.5,
      reasons:
          (json['reasons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$TestConfidenceToJson(_TestConfidence instance) =>
    <String, dynamic>{
      'level': _$ConfidenceLevelEnumMap[instance.level]!,
      'score': instance.score,
      'reasons': instance.reasons,
    };

const _$ConfidenceLevelEnumMap = {
  ConfidenceLevel.low: 'low',
  ConfidenceLevel.medium: 'medium',
  ConfidenceLevel.high: 'high',
};
