import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/models/enums.dart';

part 'test_confidence.freezed.dart';
part 'test_confidence.g.dart';

/// Engine-level confidence for a [TestResult]. Non-clinical; pairs a coarse
/// [level] with human-readable [reasons].
@freezed
abstract class TestConfidence with _$TestConfidence {
  const factory TestConfidence({
    @Default(ConfidenceLevel.medium) ConfidenceLevel level,

    /// Continuous 0..1 score (higher = more trustworthy).
    @Default(0.5) double score,

    @Default(<String>[]) List<String> reasons,
  }) = _TestConfidence;

  factory TestConfidence.fromJson(Map<String, dynamic> json) =>
      _$TestConfidenceFromJson(json);
}
