import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/calibration/calibration_provider.dart';
import 'package:sightscope/core/storage/secure_prefs.dart';
import 'package:sightscope/core/theme/app_theme.dart';
import 'package:sightscope/features/eye_wellness/domain/eye_exercise_engine.dart';
import 'package:sightscope/features/eye_wellness/presentation/eye_wellness_settings_screen.dart';
import 'package:sightscope/features/eye_wellness/presentation/one_minute_reset_screen.dart';

Widget _harness(Widget child) {
  return ProviderScope(
    overrides: [securePrefsProvider.overrideWithValue(SecurePrefs(InMemoryKeyValueStore()))],
    child: MaterialApp(theme: AppTheme.light(), home: child),
  );
}

void main() {
  testWidgets('OneMinuteResetScreen shows the first step and counts down', (tester) async {
    await tester.pumpWidget(_harness(const OneMinuteResetScreen()));
    await tester.pump();

    expect(find.text(kOneMinuteReset.first.title.toUpperCase()), findsOneWidget);
    expect(find.text('${kOneMinuteReset.first.duration.inSeconds}'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('${kOneMinuteReset.first.duration.inSeconds - 1}'), findsOneWidget);
  });

  testWidgets('OneMinuteResetScreen reaches completion after all steps elapse', (tester) async {
    await tester.pumpWidget(_harness(const OneMinuteResetScreen()));
    await tester.pump();

    final int totalSeconds = kOneMinuteReset.fold<int>(0, (sum, s) => sum + s.duration.inSeconds);
    for (int i = 0; i < totalSeconds; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.text('RESET COMPLETE'), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);
  });

  testWidgets('EyeWellnessSettingsScreen renders toggles and sensitivity options', (tester) async {
    await tester.pumpWidget(_harness(const EyeWellnessSettingsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Eye wellness reminders'), findsOneWidget);
    expect(find.text('Blink reminders'), findsOneWidget);
    expect(find.text('Balanced'), findsOneWidget);
    expect(find.text('Camera blink detection'), findsOneWidget);
  });
}
