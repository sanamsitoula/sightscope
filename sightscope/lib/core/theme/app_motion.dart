import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// Motion principles (docs/brand.md §19). Motion explains, it never
/// decorates: animate the result appearing, focus targets, test stimuli,
/// screen transitions, and progress — never everything at once.
@immutable
class AppMotion {
  const AppMotion._();

  static const Duration micro = Duration(milliseconds: 120);
  static const Duration standard = Duration(milliseconds: 240);
  static const Duration screen = Duration(milliseconds: 320);
  static const Duration result = Duration(milliseconds: 450);

  static const Curve standardCurve = Curves.easeOutCubic;
  static const Curve screenCurve = Curves.easeInOutCubic;
  static const Curve resultCurve = Curves.easeOutCubic;

  // Backwards-compatible aliases.
  static const Duration instant = micro;
  static const Duration quick = Duration(milliseconds: 150);
  static const Duration slow = result;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve incoming = Curves.easeOutCubic;
}
