import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// Motion principles. Durations are short and easing is restrained to keep
/// scientific stimuli from feeling playful (and to respect reduced-motion).
@immutable
class AppMotion {
  const AppMotion._();

  static const Duration instant = Duration(milliseconds: 80);
  static const Duration quick = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);

  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve standardCurve = Curves.easeOut;
  static const Curve incoming = Curves.easeOutCubic;
}
