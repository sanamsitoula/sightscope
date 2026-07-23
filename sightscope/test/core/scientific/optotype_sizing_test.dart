import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/scientific/optotype_sizing.dart';

void main() {
  group('OptotypeSizing', () {
    test('20/20 (logMAR 0) yields a 5-arcminute optotype with 1-arcminute critical detail', () {
      final geometry = OptotypeSizing.geometry(
        logMAR: 0,
        viewingDistanceMm: 4000, // 4m, classic Snellen distance
        ppi: 400,
      );
      expect(geometry.marArcmin, closeTo(1.0, 1e-9));
      expect(geometry.heightArcmin, closeTo(5.0, 1e-9));
      expect(geometry.strokeArcmin, closeTo(1.0, 1e-9));
      expect(geometry.gapArcmin, closeTo(1.0, 1e-9));
    });

    test('logMAR 0.3 (20/40) doubles the MAR relative to 20/20', () {
      final base = OptotypeSizing.minimumAngleOfResolutionArcmin(0);
      final worse = OptotypeSizing.minimumAngleOfResolutionArcmin(0.3);
      expect(worse / base, closeTo(2.0, 0.01));
    });

    test('decimalAcuity is the inverse of 10^logMAR', () {
      expect(OptotypeSizing.decimalAcuity(0), closeTo(1.0, 1e-9));
      expect(OptotypeSizing.decimalAcuity(1.0), closeTo(0.1, 1e-9));
    });

    test('pixel sizes scale linearly with ppi at fixed distance/logMAR', () {
      final at200 = OptotypeSizing.geometry(logMAR: 0, viewingDistanceMm: 400, ppi: 200);
      final at400 = OptotypeSizing.geometry(logMAR: 0, viewingDistanceMm: 400, ppi: 400);
      expect(at400.heightPx, closeTo(at200.heightPx * 2, 1e-6));
    });

    test('worse logMAR (larger MAR) produces a larger optotype at fixed distance/ppi', () {
      final good = OptotypeSizing.geometry(logMAR: 0.0, viewingDistanceMm: 400, ppi: 300);
      final worse = OptotypeSizing.geometry(logMAR: 0.5, viewingDistanceMm: 400, ppi: 300);
      expect(worse.heightPx, greaterThan(good.heightPx));
    });
  });
}
