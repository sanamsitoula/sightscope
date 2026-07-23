import 'dart:math';

import 'package:sightscope/core/scientific/optotype_sizing.dart';
import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_definition.dart';
import 'package:sightscope/shared/test_engine/domain/test_response.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';
import 'package:sightscope/shared/test_engine/domain/test_stimulus.dart';
import 'package:sightscope/shared/test_engine/engine/staircase.dart';

const List<int> kAcuityOrientations = [0, 90, 180, 270];
const List<String> kAcuityShapes = ['E', 'C'];

/// Adaptive logMAR staircase shared by visual acuity and near vision
/// (research/visual_acuity.md, research/near_vision.md). Alternates Tumbling
/// E and Landolt C optotypes (Task.md §14).
class AcuityTestDefinition extends TestDefinition {
  AcuityTestDefinition({
    required this.id,
    required this.version,
    required this.title,
    required this.shortDescription,
    required this.viewingDistanceMm,
    required this.ppi,
    Random? random,
  }) : _random = random ?? Random();

  @override
  final String id;
  @override
  final String version;
  @override
  final String title;
  @override
  final String shortDescription;

  final double viewingDistanceMm;
  final double ppi;
  final Random _random;

  static const StaircaseConfig practiceConfig = StaircaseConfig(
    startLevel: 0.6,
    stepSize: 0.1,
    minLevel: -0.3,
    maxLevel: 1.0,
    reversalsToTerminate: 2,
    maxTrials: 6,
  );

  static const StaircaseConfig mainConfig = StaircaseConfig(
    startLevel: 0.5,
    stepSize: 0.1,
    minLevel: -0.3,
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

    final double logMAR = staircase.level;
    final geometry = OptotypeSizing.geometry(
      logMAR: logMAR,
      viewingDistanceMm: viewingDistanceMm,
      ppi: ppi,
    );
    final String shape = kAcuityShapes[_random.nextInt(kAcuityShapes.length)];
    final int orientation = kAcuityOrientations[_random.nextInt(kAcuityOrientations.length)];

    return TestStimulus(
      id: '${isPractice ? 'practice' : 'main'}-${responsesSoFar.length}',
      payload: {
        'shape': shape,
        'orientation': orientation,
        'logMAR': logMAR,
        'heightPx': geometry.heightPx,
        'strokePx': geometry.strokePx,
        'contrast': 1.0,
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
    final double logMAR = mainStaircase.threshold;
    final TestScoring base = TestScoring.fromResponses(responses);
    return base.copyWith(
      score: logMAR,
      metrics: {
        ...base.metrics,
        'logMAR': logMAR,
        'decimalAcuity': OptotypeSizing.decimalAcuity(logMAR),
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
        ConfidenceLevel.high => 0.85,
        ConfidenceLevel.medium => 0.6,
        ConfidenceLevel.low => 0.35,
      },
      reasons: [
        if (reversals < mainConfig.reversalsToTerminate)
          'The staircase did not reach its full reversal count.',
        'Screen conditions, lighting, and viewing distance affect this result.',
      ],
    );
  }
}
