import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_shapes.dart';
import 'app_typography.dart';

/// SightScope v2 "Quiet Precision" theme (docs/brand.md).
///
/// Explicit color roles rather than a single seeded tonal palette, because
/// the brand system specifies exact hex values per role. Elevation stays at
/// 0 everywhere — hierarchy comes from spacing, background tone, borders,
/// and typography, not shadows.
@immutable
class AppTheme {
  const AppTheme._();

  static ColorScheme get _lightScheme => const ColorScheme.light(
        primary: AppColors.deepSage,
        onPrimary: Colors.white,
        secondary: AppColors.sage,
        onSecondary: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.ink,
        surfaceContainerHighest: AppColors.softSage,
        surfaceContainerHigh: AppColors.warmStone,
        surfaceContainer: AppColors.surface,
        outline: AppColors.border,
        outlineVariant: AppColors.border,
        error: AppColors.error,
        onError: Colors.white,
      );

  static ColorScheme get _darkScheme => const ColorScheme.dark(
        primary: AppColors.sage,
        onPrimary: AppColors.deepInk,
        secondary: AppColors.softSage,
        onSecondary: AppColors.deepInk,
        surface: Color(0xFF10181C),
        onSurface: Color(0xFFF7F8F6),
        surfaceContainerHighest: Color(0xFF1B2226),
        surfaceContainerHigh: Color(0xFF161C20),
        surfaceContainer: Color(0xFF10181C),
        outline: Color(0xFF2A3236),
        outlineVariant: Color(0xFF2A3236),
        error: AppColors.error,
        onError: Colors.white,
      );

  static ThemeData light() => _base(_lightScheme, AppColors.canvas);
  static ThemeData dark() => _base(_darkScheme, AppColors.deepInk);

  static ThemeData _base(ColorScheme scheme, Color scaffoldBackground) {
    final textTheme = AppTypography.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scaffoldBackground,
      splashFactory: NoSplash.splashFactory,
      highlightColor: scheme.primary.withValues(alpha: 0.06),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scaffoldBackground,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusLarge),
          side: BorderSide(color: scheme.outline, width: 1),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(64, 56),
          padding: const EdgeInsets.symmetric(horizontal: 28),
          shape: AppShapes.pill,
          textStyle: AppTypography.cardTitle,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          minimumSize: const Size(64, 56),
          padding: const EdgeInsets.symmetric(horizontal: 28),
          shape: AppShapes.pill,
          side: BorderSide(color: scheme.outline, width: 1),
          textStyle: AppTypography.cardTitle,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: scheme.onSurface),
      ),
      dividerTheme: DividerThemeData(color: scheme.outline, thickness: 1, space: 1),
    );
  }

  /// Convenience accessor for tests / dev screens.
  static ColorScheme colorScheme(Brightness brightness) =>
      brightness == Brightness.dark ? _darkScheme : _lightScheme;
}
