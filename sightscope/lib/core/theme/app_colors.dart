import 'package:flutter/material.dart';

/// Semantic color tokens for SightScope.
///
/// Built on top of Material 3 [ColorScheme] so that dark/light variants stay
/// consistent. These constants are intentionally brand-leaning; the authoritative
/// runtime colors come from [AppTheme.colorScheme].
@immutable
class AppColors {
  const AppColors._();

  // Brand seed used to derive the Material 3 tonal palette.
  static const Color brandSeed = Color(0xFF0E7C86); // calm teal — clarity/trust
  static const Color accent = Color(0xFF7A5AF8); // perception/attention accent

  // Semantic, stable across schemes (used for charts/stimuli where predictability
  // matters more than theme adaptation).
  static const Color stimulusInk = Color(0xFF111418);
  static const Color stimulusPaper = Color(0xFFFAFBFC);
  static const Color okGreen = Color(0xFF1F9D55);
  static const Color warnAmber = Color(0xFFB7791F);
}
