import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'units.dart';

/// Visual-angle ↔ physical-size conversions.
///
/// These implement the geometry required by SPEC §20 / Task.md §10. They are
/// pure functions and the sole path from a visual angle to a physical size.
///
/// Convention: `size` is the full extent (e.g., optotype height or gap width)
/// that subtends the given visual angle at the given viewing distance, assuming
/// a flat screen perpendicular to the line of sight.
@immutable
class VisualAngle {
  const VisualAngle._();

  /// Physical height [mm] of an object that subtends [visualAngleArcmin] when
  /// viewed at [viewingDistanceMm].
  ///
  /// Uses the exact chord geometry `h = 2 d tan(θ/2)` rather than the small-angle
  /// approximation, so it stays correct for large angles too.
  static double sizeMm({
    required double viewingDistanceMm,
    required double visualAngleArcmin,
  }) {
    final double halfRad = Units.arcminToRadians(visualAngleArcmin) / 2;
    return 2 * viewingDistanceMm * math.tan(halfRad);
  }

  /// Inverse of [sizeMm]: the visual angle [arcmin] subtended by [sizeMm] at
  /// [viewingDistanceMm].
  static double arcmin({
    required double viewingDistanceMm,
    required double sizeMm,
  }) {
    final double halfRad = math.atan(sizeMm / (2 * viewingDistanceMm));
    return Units.radiansToArcmin(2 * halfRad);
  }
}
