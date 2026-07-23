import 'package:flutter/material.dart';

/// Accessibility foundations (Task.md §12.2 / §23). Feature code should read
/// motion/contrast preferences through here rather than querying
/// [MediaQuery] ad hoc, so future accessibility rules stay centralized.
@immutable
class Accessibility {
  const Accessibility._();

  /// Whether the platform has requested reduced motion.
  static bool reduceMotion(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  /// Whether the platform has requested high-contrast / bold text.
  static bool highContrast(BuildContext context) =>
      MediaQuery.highContrastOf(context);

  /// Wraps [duration] to [Duration.zero] when reduced motion is requested.
  static Duration motionDuration(BuildContext context, Duration duration) =>
      reduceMotion(context) ? Duration.zero : duration;
}
