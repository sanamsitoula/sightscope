import 'package:flutter/material.dart';

/// Shape system tokens (border radii in logical pixels).
@immutable
class AppShapes {
  const AppShapes._();

  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;

  static const RoundedRectangleBorder small = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(radiusSm)),
  );

  static const RoundedRectangleBorder medium = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(radiusMd)),
  );

  static const RoundedRectangleBorder large = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(radiusLg)),
  );

  static const StadiumBorder stadium = StadiumBorder();
}
