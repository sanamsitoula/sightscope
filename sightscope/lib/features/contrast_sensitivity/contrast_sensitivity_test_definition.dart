import 'dart:math';

import 'package:sightscope/core/scientific/optotype_sizing.dart';
import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';
import 'package:sightscope/shared/test_engine/engine/staircase.dart';

import '../visual_acuity/acuity_test_definition.dart' show kAcuityOrientations;

/// Adaptive contrast staircase (research/contrast_sensitivity.md). Optotype
/// size is held fixed (well above the acuity threshold); only contrast is
/// adapted, so size never confounds the contrast measurement.
class ContrastSensitivityTestDefinition extends TestDefinition {
  ContrastSensitivityTestDefinition({
    required this.viewingDistanceMm,
    required this.ppi,
    Random? random,
  }) : _random = random ?? Random();

  @override
  String get id => 'contrast_sensitivity';
  @override
  String get version => '1.0.0';
  @override
  String get title => 'Contrast Sensitivity';
  @override
  String get shortDescription =>
      'Screens how well you detect a fixed-size shape as its contrast fades.';

  final double viewingDistanceMm;
  final double ppi;
  final Random _random;

  /// Fixed, generously large logMAR so size is never the limiting factor.
  static const double fixedLogMAR = 0.3;

  static const StaircaseConfig practiceConfig = StaircaseConfig(
    startLevel: 0.7,
    stepSize: 0.15,
    minLevel: 0.02,
    maxLevel: 1.0,
    reversalsToTerminate: 2,
    maxTrials: 6,
  );

  static const StaircaseConfig mainConfig = StaircaseConfig(
    startLevel: 0.5,
    stepSize: 0.1,
    minLevel: 0.02,
    maxLevel: 1.0,
    reversalsToTerminate: 4,
    maxTrials: 14,
  );

  Staircase? _practiceStaircase;
  Staircase? _mainStaircase;

  Staircase get mainStaircase => _mainStaircase ??= Staircase(mainConfig);

  @override
  bool get isAdaptive => true;

  @override
  List<TestStimulus> buildPracticeStimuli() => const <TestStimulus>[];

  @override
  List<TestStimulus> buildMainStimuli() => const <TestStimulus>[];

  @override
  TestStimulus? nextAdaptiveStimulus({
    required bool isPractice,
    required List<TestResponse> responsesSoFar,
  }) {
    final Staircase staircase =
        isPractice ? (_practiceStaircase ??= Staircase(practiceConfig)) : mainStaircase;
    if (responsesSoFar.isNotEmpty) {
      staircase.recordResponse(responsesSoFar.last.correct);
    }
    if (staircase.isDone) return null;

    final double contrast = staircase.level;
    final geometry = OptotypeSizing.geometry(
      logMAR: fixedLogMAR,
      viewingDistanceMm: viewingDistanceMm,
      ppi: ppi,
    );
    final int orientation = kAcuityOrientations[_random.nextInt(kAcuityOrientations.length)];

    return TestStimulus(
      id: '${isPractice ? 'practice' : 'main'}-${responsesSoFar.length}',
      payload: {
        'shape': 'E',
        'orientation': orientation,
        'logMAR': fixedLogMAR,
        'heightPx': geometry.heightPx,
        'strokePx': geometry.strokePx,
        'contrast': contrast,
      },
    );
  }

  @override
  TestResponse evaluateResponse({
    required TestStimulus stimulus,
    required Map<String, dynamic> answer,
    required int durationMillis,
  }) {
    final int expected = stimulus.payload['orientation'] as int;
    final int? chosen = answer['orientation'] as int?;
    return TestResponse(
      stimulus: stimulus,
      answer: answer,
      correct: chosen == expected,
      durationMillis: durationMillis,
      recordedAtEpochMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  TestScoring score(List<TestResponse> responses) {
    final double weberContrast = mainStaircase.threshold.clamp(0.001, 1.0);
    final double logCS = -(log(weberContrast) / ln10);
    final TestScoring base = TestScoring.fromResponses(responses);
    return base.copyWith(
      score: logCS,
      metrics: {
        ...base.metrics,
        'weberContrast': weberContrast,
        'logCS': logCS,
        'reversals': mainStaircase.reversalLevels.length,
      },
    );
  }

  @override
  TestConfidence assessConfidence({
    required TestScoring scoring,
    required List<TestResponse> responses,
  }) {
    final int reversals = (scoring.metrics['reversals'] as int?) ?? 0;
    final ConfidenceLevel level = reversals >= mainConfig.reversalsToTerminate
        ? ConfidenceLevel.high
        : (reversals >= 2 ? ConfidenceLevel.medium : ConfidenceLevel.low);
    return TestConfidence(
      level: level,
      score: switch (level) {
        ConfidenceLevel.high => 0.8,
        ConfidenceLevel.medium => 0.55,
        ConfidenceLevel.low => 0.3,
      },
      reasons: [
        if (reversals < mainConfig.reversalsToTerminate)
          'The staircase did not reach its full reversal count.',
        'Screen brightness and room lighting strongly affect this result — '
            'do not compare across devices or lighting conditions.',
      ],
    );
  }
}
