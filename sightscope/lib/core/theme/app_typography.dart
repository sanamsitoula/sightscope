import 'package:flutter/material.dart';

/// Typography scale. Uses the platform default Material 3 type scale but
/// exposes named semantic styles so feature code never hard-codes sizes.
@immutable
class AppTypography {
  const AppTypography._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.15,
  );
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );
  static const TextStyle titleLarge = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  /// Optotype-adjacent text baseline for result readouts.
  static const TextStyle metricValue = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextTheme get textTheme => const TextTheme(
        displayLarge: displayLarge,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        titleLarge: titleLarge,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        labelLarge: labelLarge,
        labelSmall: labelSmall,
      );
}
