import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/calibration/calibration_math.dart';

void main() {
  group('CalibrationMath', () {
    test('ppiFromPhysicalEdge computes true PPI from a credit-card edge', () {
      // A 1920px measured edge for the 85.60mm long edge of a card.
      final double ppi = CalibrationMath.ppiFromPhysicalEdge(
        measuredEdgePx: 1920,
        physicalEdgeMm: CalibrationMath.creditCardLongEdgeMm,
      );
      // 85.60mm = 3.3701" -> 1920 / 3.3701 ≈ 569.75
      expect(ppi, closeTo(569.75, 0.5));
    });

    test('mmToPixels and pixelsToMm are inverses', () {
      const double ppi = 460.0;
      const double mm = 12.7; // half inch
      final double px = CalibrationMath.mmToPixels(mm: mm, ppi: ppi);
      final double roundTrip = CalibrationMath.pixelsToMm(px: px, ppi: ppi);
      expect(roundTrip, closeTo(mm, 1e-9));
      expect(px, closeTo(230.0, 1e-9)); // 0.5in * 460ppi
    });

    test('ppiFromDiagonal computes density from native pixel dims', () {
      final double ppi = CalibrationMath.ppiFromDiagonal(
        widthPx: 1080,
        heightPx: 2400,
        diagonalInches: 6.1,
      );
      expect(ppi, closeTo(431.5, 1.0));
    });
  });
}
