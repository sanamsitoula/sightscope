// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalibrationResult _$CalibrationResultFromJson(Map<String, dynamic> json) =>
    _CalibrationResult(
      ppi: (json['ppi'] as num).toDouble(),
      method: $enumDecode(_$CalibrationMethodEnumMap, json['method']),
      calibratedAt: DateTime.parse(json['calibratedAt'] as String),
      screenWpx: (json['screenWpx'] as num?)?.toInt() ?? 0,
      screenHpx: (json['screenHpx'] as num?)?.toInt() ?? 0,
      diagonalInches: (json['diagonalInches'] as num?)?.toDouble() ?? 0.0,
      viewingDistanceMm:
          (json['viewingDistanceMm'] as num?)?.toDouble() ?? 400.0,
    );

Map<String, dynamic> _$CalibrationResultToJson(_CalibrationResult instance) =>
    <String, dynamic>{
      'ppi': instance.ppi,
      'method': _$CalibrationMethodEnumMap[instance.method]!,
      'calibratedAt': instance.calibratedAt.toIso8601String(),
      'screenWpx': instance.screenWpx,
      'screenHpx': instance.screenHpx,
      'diagonalInches': instance.diagonalInches,
      'viewingDistanceMm': instance.viewingDistanceMm,
    };

const _$CalibrationMethodEnumMap = {
  CalibrationMethod.creditCard: 'creditCard',
  CalibrationMethod.deviceDefault: 'deviceDefault',
  CalibrationMethod.fallback: 'fallback',
};
