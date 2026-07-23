import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/scientific/visual_angle.dart';

void main() {
  group('VisualAngle', () {
    test('sizeMm and arcmin are inverses', () {
      const double distanceMm = 400;
      const double angle = 30.0; // arcmin
      final double size = VisualAngle.sizeMm(
        viewingDistanceMm: distanceMm,
        visualAngleArcmin: angle,
      );
      final double roundTrip = VisualAngle.arcmin(
        viewingDistanceMm: distanceMm,
        sizeMm: size,
      );
      expect(roundTrip, closeTo(angle, 1e-6));
    });

    test('larger viewing distance requires a larger physical size for the same angle', () {
      const double angle = 5.0;
      final double sizeNear = VisualAngle.sizeMm(viewingDistanceMm: 400, visualAngleArcmin: angle);
      final double sizeFar = VisualAngle.sizeMm(viewingDistanceMm: 800, visualAngleArcmin: angle);
      expect(sizeFar, greaterThan(sizeNear));
      expect(sizeFar, closeTo(sizeNear * 2, 1e-6));
    });

    test('matches the small-angle approximation at small angles', () {
      // h ≈ d * theta(rad) for small theta.
      const double distanceMm = 400;
      const double angleArcmin = 5.0;
      final double exact = VisualAngle.sizeMm(
        viewingDistanceMm: distanceMm,
        visualAngleArcmin: angleArcmin,
      );
      const double thetaRad = angleArcmin / 60 * 3.14159265358979 / 180;
      const double approx = distanceMm * thetaRad;
      expect(exact, closeTo(approx, 1e-3));
    });
  });
}
