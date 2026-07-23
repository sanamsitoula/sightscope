import 'package:freezed_annotation/freezed_annotation.dart';

import 'test_stimulus.dart';

part 'test_response.freezed.dart';
part 'test_response.g.dart';

/// A single recorded response to a [stimulus] during a test session.
///
/// [answer] is test-defined (mirrors [TestStimulus.payload]). [durationMillis]
/// enables reaction-time accounting without leaking test semantics into the
/// engine.
@freezed
abstract class TestResponse with _$TestResponse {
  const factory TestResponse({
    required TestStimulus stimulus,

    /// What the user answered (test-defined shape).
    required Map<String, dynamic> answer,

    /// Whether the response matched the stimulus' expected answer.
    @Default(false) bool correct,

    /// Time from stimulus presentation to response, in milliseconds.
    @Default(0) int durationMillis,

    /// Epoch timestamp (ms) at which the response was recorded.
    int? recordedAtEpochMs,
  }) = _TestResponse;

  factory TestResponse.fromJson(Map<String, dynamic> json) =>
      _$TestResponseFromJson(json);
}
