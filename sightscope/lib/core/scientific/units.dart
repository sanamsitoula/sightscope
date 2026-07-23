import 'dart:math' show pi;

import 'package:flutter/foundation.dart';

/// Physical-unit conversion constants and helpers.
///
/// All SightScope physical math flows through here so there is a single
/// authoritative definition of the millimetre↔inch and angle conversions.
@immutable
class Units {
  const Units._();

  /// Exact: 1 international inch = 25.4 mm.
  static const double mmPerInch = 25.4;

  /// 1 degree = 60 arcminutes.
  static const double arcminPerDegree = 60.0;

  /// 1 degree in radians.
  static const double radiansPerDegree = pi / 180.0;

  static double inchesToMm(double inches) => inches * mmPerInch;
  static double mmToInches(double mm) => mm / mmPerInch;

  static double degreesToRadians(double deg) => deg * radiansPerDegree;

  static double arcminToRadians(double arcmin) =>
      degreesToRadians(arcmin / arcminPerDegree);

  static double radiansToArcmin(double rad) =>
      rad / radiansPerDegree * arcminPerDegree;
}
