import 'package:flutter/material.dart';

/// SightScope v2 — "Quiet Precision" palette (docs/brand.md v2).
///
/// A restrained ink/sage/stone system, not a rainbow of test colors. Gold is
/// reserved for rare, deliberate highlight moments — never a general UI
/// color. Semantic colors stay muted rather than highly saturated.
@immutable
class AppColors {
  const AppColors._();

  /// Primary text, dark surfaces, primary visual weight.
  static const Color ink = Color(0xFF101820);

  /// Splash screens, premium hero areas, dark result moments.
  static const Color deepInk = Color(0xFF071014);

  /// Main application background.
  static const Color canvas = Color(0xFFF7F8F6);

  /// Cards, elevated content areas, test surfaces.
  static const Color surface = Color(0xFFFFFFFF);

  /// Primary brand accent — brand marks, focus indicators, positive emphasis.
  static const Color sage = Color(0xFF6F9188);

  /// High-emphasis brand color — primary buttons, strong interactive/selected states.
  static const Color deepSage = Color(0xFF42665F);

  /// Subtle containers, selected backgrounds, soft information areas.
  static const Color softSage = Color(0xFFE8EFEC);

  /// Neutral secondary surface — calibration, supporting content, empty states.
  static const Color warmStone = Color(0xFFE9E6DF);

  /// Extremely sparing use only: milestones, premium moments, metric highlights.
  /// Must never become a general UI color.
  static const Color gold = Color(0xFFB39A63);

  /// Standard hairline border. Barely visible — structure, not decoration.
  static const Color border = Color(0xFFE3E7E4);

  // Semantic (muted, not saturated).
  static const Color success = Color(0xFF3F806C);
  static const Color caution = Color(0xFFA77B43);
  static const Color error = Color(0xFFA45D5D);
  static const Color info = Color(0xFF66838C);

  // Stimulus rendering intentionally stays brand-neutral — "the brand
  // should disappear during measurement" (docs/brand.md §18).
  static const Color stimulusInk = ink;
  static const Color stimulusPaper = surface;
}
