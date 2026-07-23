import 'package:flutter/material.dart';

/// SightScope v2 type scale — confident but quiet (docs/brand.md §5).
@immutable
class AppTypography {
  const AppTypography._();

  /// Main result values, major brand moments, splash messaging.
  static const TextStyle display = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1.10,
    letterSpacing: -1.0,
  );

  /// Dashboard hero, major screen titles.
  static const TextStyle hero = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 1.15,
    letterSpacing: -0.5,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.30,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.50,
  );

  static const TextStyle secondary = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  /// Small uppercase editorial label, e.g. "LAST SESSION". Apply
  /// `.toUpperCase()` to the string — this style does not transform case.
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.8,
  );

  /// Test result values — visually dominant, tabular so digits don't jitter.
  static const TextStyle metric = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    letterSpacing: -1.5,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextTheme get textTheme => const TextTheme(
        displayLarge: display,
        headlineLarge: hero,
        headlineMedium: hero,
        titleLarge: sectionTitle,
        titleMedium: cardTitle,
        bodyLarge: body,
        bodyMedium: secondary,
        labelLarge: overline,
        labelSmall: overline,
      );
}
