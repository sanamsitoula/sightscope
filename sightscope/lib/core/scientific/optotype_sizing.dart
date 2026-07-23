import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../calibration/calibration_math.dart';
import 'optotype_geometry.dart';
import 'visual_angle.dart';

/// The single authoritative optotype-sizing entry point (Task.md §10).
///
/// All tests that draw optotypes MUST size them through [OptotypeSizing.geometry]
/// — never by hard-coding pixel constants.
@immutable
class OptotypeSizing {
  const OptotypeSizing._();

  /// Minimum angle of resolution [arcmin] for a given logMAR value.
  ///
  /// logMAR 0   (20/20)  -> MAR 1.0 arcmin
  /// logMAR 0.3 (20/40)  -> MAR ~2.0 arcmin
  /// logMAR 1.0 (20/200) -> MAR 10  arcmin
  static double minimumAngleOfResolutionArcmin(double logMAR) =>
      math.pow(10, logMAR).toDouble();

  /// Decimal acuity for a logMAR value (1 / 10^logMAR).
  static double decimalAcuity(double logMAR) => 1 / math.pow(10, logMAR);

  /// Standard 5-part optotype geometry for the given logMAR line.
  static OptotypeGeometry geometry({
    required double logMAR,
    required double viewingDistanceMm,
    required double ppi,
  }) {
    final double mar = minimumAngleOfResolutionArcmin(logMAR);
    final double heightArcmin = 5 * mar;
    final double strokeArcmin = mar;
    final double gapArcmin = mar;

    final double heightMm = VisualAngle.sizeMm(
      viewingDistanceMm: viewingDistanceMm,
      visualAngleArcmin: heightArcmin,
    );
    final double strokeMm = VisualAngle.sizeMm(
      viewingDistanceMm: viewingDistanceMm,
      visualAngleArcmin: strokeArcmin,
    );
    final double gapMm = VisualAngle.sizeMm(
      viewingDistanceMm: viewingDistanceMm,
      visualAngleArcmin: gapArcmin,
    );

    return OptotypeGeometry(
      logMAR: logMAR,
      marArcmin: mar,
      heightArcmin: heightArcmin,
      strokeArcmin: strokeArcmin,
      gapArcmin: gapArcmin,
      heightMm: heightMm,
      strokeMm: strokeMm,
      gapMm: gapMm,
      heightPx: CalibrationMath.mmToPixels(mm: heightMm, ppi: ppi),
      strokePx: CalibrationMath.mmToPixels(mm: strokeMm, ppi: ppi),
      gapPx: CalibrationMath.mmToPixels(mm: gapMm, ppi: ppi),
      viewingDistanceMm: viewingDistanceMm,
      ppi: ppi,
    );
  }

  /// Convenience: arcminute value of the full optotype at a given logMAR.
  static double fullHeightArcmin(double logMAR) =>
      5 * minimumAngleOfResolutionArcmin(logMAR);
}
