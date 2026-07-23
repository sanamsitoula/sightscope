import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// SightScope Material 3 theme.
///
/// Phase 0 provides light + dark [ThemeData]. No dashboard is built yet;
/// these tokens exist so feature code (Phase 1+) has a single source of truth.
@immutable
class AppTheme {
  const AppTheme._();

  static ColorScheme get _lightScheme =>
      ColorScheme.fromSeed(seedColor: AppColors.brandSeed, brightness: Brightness.light);
  static ColorScheme get _darkScheme =>
      ColorScheme.fromSeed(seedColor: AppColors.brandSeed, brightness: Brightness.dark);

  static ThemeData light() => _base(_lightScheme);
  static ThemeData dark() => _base(_darkScheme);

  static ThemeData _base(ColorScheme scheme) {
    final textTheme = AppTypography.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainer,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const StadiumBorder(),
        ),
      ),
    );
  }

  /// Convenience accessor for tests / dev screens.
  static ColorScheme colorScheme(Brightness brightness) =>
      brightness == Brightness.dark ? _darkScheme : _lightScheme;
}
