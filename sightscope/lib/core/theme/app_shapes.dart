import 'package:flutter/material.dart';

/// Shape system tokens (docs/brand.md §7). Soft but not playful.
@immutable
class AppShapes {
  const AppShapes._();

  static const double radiusSmall = 8;
  static const double radiusMedium = 14;
  static const double radiusLarge = 20;
  static const double radiusXl = 28;

  // Backwards-compatible aliases used by earlier call sites.
  static const double radiusXs = 4;
  static const double radiusSm = radiusSmall;
  static const double radiusMd = radiusMedium;
  static const double radiusLg = radiusLarge;

  static const RoundedRectangleBorder small = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(radiusSmall)),
  );

  static const RoundedRectangleBorder medium = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
  );

  static const RoundedRectangleBorder large = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(radiusLarge)),
  );

  static const RoundedRectangleBorder extraLarge = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(radiusXl)),
  );

  /// Pill shape — reserved for primary buttons, tags, small status
  /// indicators only (docs/brand.md §7).
  static const StadiumBorder pill = StadiumBorder();
  static const StadiumBorder stadium = pill;
}
