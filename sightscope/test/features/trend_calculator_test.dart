import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/features/trends/trend_calculator.dart';
import 'package:sightscope/shared/models/enums.dart';
import 'package:sightscope/shared/test_engine/domain/test_confidence.dart';
import 'package:sightscope/shared/test_engine/domain/test_result.dart';
import 'package:sightscope/shared/test_engine/domain/test_scoring.dart';

TestResult _result(String testId, DateTime date, double score) => TestResult(
      testId: testId,
      testVersion: '1.0.0',
      date: date,
      deviceModel: 'test',
      screenSize: '0x0',
      screenDensity: 0,
      eyeTested: Eye.both,
      correctionUsed: CorrectionUsed.unknown,
      scoring: TestScoring(score: score),
      confidence: const TestConfidence(),
    );

void main() {
  group('TrendCalculator', () {
    test('returns null for an empty result list', () {
      expect(TrendCalculator.summarize('visual_acuity', []), isNull);
    });

    test('single result reports insufficientData', () {
      final summary = TrendCalculator.summarize(
        'visual_acuity',
        [_result('visual_acuity', DateTime(2026, 1, 1), 0.2)],
      );
      expect(summary!.direction, TrendDirection.insufficientData);
      expect(summary.sampleCount, 1);
    });

    test('baseline is the earliest result and current is the latest, regardless of input order', () {
      final summary = TrendCalculator.summarize('visual_acuity', [
        _result('visual_acuity', DateTime(2026, 3, 1), 0.1),
        _result('visual_acuity', DateTime(2026, 1, 1), 0.4),
        _result('visual_acuity', DateTime(2026, 2, 1), 0.25),
      ]);
      expect(summary!.baseline.date, DateTime(2026, 1, 1));
      expect(summary.current.date, DateTime(2026, 3, 1));
      expect(summary.sampleCount, 3);
    });

    test('a small difference within tolerance is reported as stable', () {
      final summary = TrendCalculator.summarize('reaction_time', [
        _result('reaction_time', DateTime(2026, 1, 1), 300.0),
        _result('reaction_time', DateTime(2026, 1, 2), 305.0),
      ]);
      expect(summary!.direction, TrendDirection.stable);
    });

    test('a clear increase is reported as higher', () {
      final summary = TrendCalculator.summarize('contrast_sensitivity', [
        _result('contrast_sensitivity', DateTime(2026, 1, 1), 1.0),
        _result('contrast_sensitivity', DateTime(2026, 1, 2), 1.5),
      ]);
      expect(summary!.direction, TrendDirection.higher);
    });

    test('a clear decrease is reported as lower', () {
      final summary = TrendCalculator.summarize('contrast_sensitivity', [
        _result('contrast_sensitivity', DateTime(2026, 1, 1), 1.5),
        _result('contrast_sensitivity', DateTime(2026, 1, 2), 1.0),
      ]);
      expect(summary!.direction, TrendDirection.lower);
    });

    test('groupByTestId separates dimensions and never merges them', () {
      final grouped = TrendCalculator.groupByTestId([
        _result('visual_acuity', DateTime(2026, 1, 1), 0.2),
        _result('reaction_time', DateTime(2026, 1, 1), 300),
        _result('visual_acuity', DateTime(2026, 1, 2), 0.1),
      ]);
      expect(grouped.keys.toSet(), {'visual_acuity', 'reaction_time'});
      expect(grouped['visual_acuity'], hasLength(2));
      expect(grouped['reaction_time'], hasLength(1));
    });
  });
}
