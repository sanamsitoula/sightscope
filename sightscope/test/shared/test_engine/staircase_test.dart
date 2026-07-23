import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/shared/test_engine/engine/staircase.dart';

void main() {
  group('Staircase', () {
    test('two-down-one-up steps harder after 2 correct, easier after 1 incorrect', () {
      final s = Staircase(const StaircaseConfig(
        startLevel: 0.5,
        stepSize: 0.1,
        minLevel: -0.2,
        maxLevel: 1.0,
      ));
      s.recordResponse(true);
      expect(s.level, closeTo(0.5, 1e-9)); // only 1 correct so far, no step yet
      s.recordResponse(true);
      expect(s.level, closeTo(0.4, 1e-9)); // 2 correct -> harder (lower)
      s.recordResponse(false);
      expect(s.level, closeTo(0.5, 1e-9)); // 1 incorrect -> easier (higher)
    });

    test('clamps to min/max level', () {
      final s = Staircase(const StaircaseConfig(
        startLevel: 0.0,
        stepSize: 0.5,
        minLevel: 0.0,
        maxLevel: 1.0,
      ));
      s.recordResponse(true);
      s.recordResponse(true); // would go to -0.5, clamps to 0.0
      expect(s.level, 0.0);
    });

    test('terminates after reversalsToTerminate reversals', () {
      final s = Staircase(const StaircaseConfig(
        startLevel: 0.5,
        stepSize: 0.1,
        minLevel: -1,
        maxLevel: 1,
        reversalsToTerminate: 2,
        maxTrials: 100,
      ));
      // correct, correct (harder), incorrect (easier, reversal 1), correct, correct (harder, reversal 2)
      s.recordResponse(true);
      s.recordResponse(true);
      expect(s.isDone, isFalse);
      s.recordResponse(false);
      expect(s.reversalLevels.length, 1);
      s.recordResponse(true);
      s.recordResponse(true);
      expect(s.reversalLevels.length, 2);
      expect(s.isDone, isTrue);
    });

    test('terminates at maxTrials even without enough reversals', () {
      final s = Staircase(const StaircaseConfig(
        startLevel: 0.5,
        stepSize: 0.1,
        minLevel: -1,
        maxLevel: 1,
        reversalsToTerminate: 10,
        maxTrials: 3,
      ));
      s.recordResponse(true);
      s.recordResponse(false);
      expect(s.isDone, isFalse);
      s.recordResponse(true);
      expect(s.isDone, isTrue);
    });

    test('threshold is the mean of the last N reversal levels', () {
      final s = Staircase(const StaircaseConfig(
        startLevel: 0.5,
        stepSize: 0.1,
        minLevel: -1,
        maxLevel: 1,
        reversalsUsedForThreshold: 2,
      ));
      // Drive a few reversals: correct,correct(harder->0.4), incorrect(easier->0.5, rev1),
      // correct,correct(harder->0.4, rev2), incorrect(easier->0.5, rev3)
      s.recordResponse(true);
      s.recordResponse(true);
      s.recordResponse(false);
      s.recordResponse(true);
      s.recordResponse(true);
      s.recordResponse(false);
      expect(s.reversalLevels.length, 3);
      // last 2 reversals: 0.4 and 0.5 -> mean 0.45
      expect(s.threshold, closeTo(0.45, 1e-9));
    });

    test('threshold falls back to current level when there are no reversals yet', () {
      final s = Staircase(const StaircaseConfig(
        startLevel: 0.3,
        stepSize: 0.1,
        minLevel: -1,
        maxLevel: 1,
      ));
      expect(s.threshold, 0.3);
    });

    test('harderIsLower=false makes harder mean increasing the level', () {
      final s = Staircase(const StaircaseConfig(
        startLevel: 0.2,
        stepSize: 0.1,
        minLevel: 0,
        maxLevel: 1,
        harderIsLower: false,
      ));
      s.recordResponse(true);
      s.recordResponse(true);
      expect(s.level, closeTo(0.3, 1e-9));
    });
  });
}
