// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestResult _$TestResultFromJson(Map<String, dynamic> json) => _TestResult(
  testId: json['testId'] as String,
  testVersion: json['testVersion'] as String,
  date: DateTime.parse(json['date'] as String),
  deviceModel: json['deviceModel'] as String,
  screenSize: json['screenSize'] as String,
  screenDensity: (json['screenDensity'] as num).toDouble(),
  brightnessIfAvailable: (json['brightnessIfAvailable'] as num?)?.toDouble(),
  viewingDistance: (json['viewingDistance'] as num?)?.toDouble(),
  eyeTested: $enumDecode(_$EyeEnumMap, json['eyeTested']),
  correctionUsed: $enumDecode(_$CorrectionUsedEnumMap, json['correctionUsed']),
  rawResponses:
      (json['rawResponses'] as List<dynamic>?)
          ?.map((e) => TestResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TestResponse>[],
  scoring: TestScoring.fromJson(json['scoring'] as Map<String, dynamic>),
  confidence: TestConfidence.fromJson(
    json['confidence'] as Map<String, dynamic>,
  ),
  environmentNotes: json['environmentNotes'] as String?,
  sessionId: json['sessionId'] as String?,
);

Map<String, dynamic> _$TestResultToJson(_TestResult instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'testVersion': instance.testVersion,
      'date': instance.date.toIso8601String(),
      'deviceModel': instance.deviceModel,
      'screenSize': instance.screenSize,
      'screenDensity': instance.screenDensity,
      'brightnessIfAvailable': instance.brightnessIfAvailable,
      'viewingDistance': instance.viewingDistance,
      'eyeTested': _$EyeEnumMap[instance.eyeTested]!,
      'correctionUsed': _$CorrectionUsedEnumMap[instance.correctionUsed]!,
      'rawResponses': instance.rawResponses,
      'scoring': instance.scoring,
      'confidence': instance.confidence,
      'environmentNotes': instance.environmentNotes,
      'sessionId': instance.sessionId,
    };

const _$EyeEnumMap = {Eye.left: 'left', Eye.right: 'right', Eye.both: 'both'};

const _$CorrectionUsedEnumMap = {
  CorrectionUsed.none: 'none',
  CorrectionUsed.glasses: 'glasses',
  CorrectionUsed.contacts: 'contacts',
  CorrectionUsed.unknown: 'unknown',
};
