import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/calibration/calibration_provider.dart';
import 'package:sightscope/core/storage/database.dart';
import 'package:sightscope/core/storage/database_provider.dart';
import 'package:sightscope/core/storage/secure_prefs.dart';
import 'package:sightscope/core/theme/app_theme.dart';
import 'package:sightscope/features/color_vision/color_vision_screen.dart';
import 'package:sightscope/features/contrast_sensitivity/contrast_sensitivity_screen.dart';
import 'package:sightscope/features/education/education_screen.dart';
import 'package:sightscope/features/history/history_screen.dart';
import 'package:sightscope/features/near_vision/near_vision_screen.dart';
import 'package:sightscope/features/onboarding/calibration_screen.dart';
import 'package:sightscope/features/reaction_time/reaction_time_screen.dart';
import 'package:sightscope/features/visual_acuity/visual_acuity_screen.dart';

Widget _harness(Widget child, AppDatabase db) {
  return ProviderScope(
    overrides: [
      securePrefsProvider.overrideWithValue(SecurePrefs(InMemoryKeyValueStore())),
      appDatabaseProvider.overrideWithValue(db),
    ],
    child: MaterialApp(theme: AppTheme.light(), home: child),
  );
}

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase.forTesting());
  tearDown(() => db.close());

  testWidgets('CalibrationScreen renders and confirm button saves calibration', (tester) async {
    await tester.pumpWidget(_harness(const CalibrationScreen(), db));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('calibration_card_outline')), findsOneWidget);
    expect(find.text('Confirm calibration'), findsOneWidget);
  });

  testWidgets('VisualAcuityScreen shows intro then starts a trial', (tester) async {
    await tester.pumpWidget(_harness(const VisualAcuityScreen(), db));
    await tester.pumpAndSettle();
    expect(find.text('Start'), findsOneWidget);
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.text('Continue'), findsOneWidget); // instructions phase
  });

  testWidgets('NearVisionScreen shows intro', (tester) async {
    await tester.pumpWidget(_harness(const NearVisionScreen(), db));
    await tester.pumpAndSettle();
    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('ContrastSensitivityScreen shows intro', (tester) async {
    await tester.pumpWidget(_harness(const ContrastSensitivityScreen(), db));
    await tester.pumpAndSettle();
    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('ColorVisionScreen shows intro then a plate', (tester) async {
    await tester.pumpWidget(_harness(const ColorVisionScreen(), db));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.text('None visible'), findsOneWidget);
  });

  testWidgets('ReactionTimeScreen shows intro then waiting state', (tester) async {
    await tester.pumpWidget(_harness(const ReactionTimeScreen(), db));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pump();
    expect(find.textContaining('Wait'), findsOneWidget);
    // Flush the pending stimulus-onset timer so it doesn't leak into other tests.
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('HistoryScreen shows empty state with no results', (tester) async {
    await tester.pumpWidget(_harness(const HistoryScreen(), db));
    await tester.pumpAndSettle();
    expect(find.text('No results yet. Complete a test to see it here.'), findsOneWidget);
  });

  testWidgets('EducationScreen lists topics', (tester) async {
    await tester.pumpWidget(_harness(const EducationScreen(), db));
    await tester.pumpAndSettle();
    expect(find.text('The retina'), findsOneWidget);
  });
}
