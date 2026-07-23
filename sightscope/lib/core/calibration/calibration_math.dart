import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../scientific/units.dart';

/// The single authoritative calibration math (Task.md §10).
///
/// Implements true-PPI calculation, millimetre↔pixel conversion, and the
/// diagonal-based fallback PPI. All stimulus sizing must route through the
/// [CalibrationService], which builds on these primitives.
@immutable
class CalibrationMath {
  const CalibrationMath._();

  /// ISO/IEC 7810-1 ID-1 (credit-card) dimensions in millimetres.
  static const double creditCardLongEdgeMm = 85.60;
  static const double creditCardShortEdgeMm = 53.98;

  /// True PPI from a physically-known edge measured in device pixels.
  ///
  /// [measuredEdgePx] is the number of pixels spanned by an object of length
  /// [physicalEdgeMm] laid flat against the screen.
  static double ppiFromPhysicalEdge({
    required double measuredEdgePx,
    required double physicalEdgeMm,
  }) {
    assert(measuredEdgePx > 0);
    assert(physicalEdgeMm > 0);
    return measuredEdgePx / Units.mmToInches(physicalEdgeMm);
  }

  /// Millimetres → device pixels at [ppi].
  static double mmToPixels({required double mm, required double ppi}) =>
      Units.mmToInches(mm) * ppi;

  /// Device pixels → millimetres at [ppi].
  static double pixelsToMm({required double px, required double ppi}) =>
      Units.inchesToMm(px / ppi);

  /// Diagonal PPI from native pixel dimensions and physical diagonal inches.
  static double ppiFromDiagonal({
    required double widthPx,
    required double heightPx,
    required double diagonalInches,
  }) {
    assert(diagonalInches > 0);
    final double diagPx = math.sqrt(widthPx * widthPx + heightPx * heightPx);
    return diagPx / diagonalInches;
  }
}
