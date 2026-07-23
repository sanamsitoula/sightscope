import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_stimulus.freezed.dart';
part 'test_stimulus.g.dart';

/// An opaque, test-defined stimulus payload presented during a test.
///
/// Tests own their stimulus representation (e.g. an optotype + orientation) and
/// encode/decode it through [payload]. The engine itself is stimulus-agnostic.
@freezed
abstract class TestStimulus with _$TestStimulus {
  const factory TestStimulus({
    /// Stable id within the test (e.g. "trial-007").
    required String id,

    /// Test-specific stimulus data (always JSON-serializable primitives).
    required Map<String, dynamic> payload,
  }) = _TestStimulus;

  factory TestStimulus.fromJson(Map<String, dynamic> json) =>
      _$TestStimulusFromJson(json);
}
