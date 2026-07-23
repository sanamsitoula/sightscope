import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/core/calibration/calibration_provider.dart';
import 'package:sightscope/core/storage/database.dart';
import 'package:sightscope/core/storage/database_provider.dart';
import 'package:sightscope/core/storage/secure_prefs.dart';
import 'package:sightscope/core/theme/app_theme.dart';
import 'package:sightscope/features/eye_fatigue/eye_fatigue_screen.dart';
import 'package:sightscope/features/motion_perception/motion_perception_screen.dart';
import 'package:sightscope/features/peripheral_vision/peripheral_vision_screen.dart';
import 'package:sightscope/features/profile/profile_screen.dart';
import 'package:sightscope/features/stereo_vision/depth_perception_screen.dart';
import 'package:sightscope/features/trends/trends_screen.dart';
import 'package:sightscope/features/visual_attention/visual_attention_screen.dart';
import 'package:sightscope/features/visual_memory/visual_memory_screen.dart';

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

  testWidgets('DepthPerceptionScreen shows intro then a trial', (tester) async {
    await tester.pumpWidget(_harness(const DepthPerceptionScreen(), db));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.byType(GestureDetector), findsWidgets);
  });

  testWidgets('PeripheralVisionScreen shows intro', (tester) async {
    await tester.pumpWidget(_harness(const PeripheralVisionScreen(), db));
    await tester.pumpAndSettle();
    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('VisualAttentionScreen shows intro then trial targets', (tester) async {
    await tester.pumpWidget(_harness(const VisualAttentionScreen(), db));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.byType(GestureDetector), findsWidgets);
  });

  testWidgets('VisualMemoryScreen shows intro then study stage', (tester) async {
    await tester.pumpWidget(_harness(const VisualMemoryScreen(), db));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pump();
    expect(find.text('Remember…'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 2600));
  });

  testWidgets('MotionPerceptionScreen shows intro then plays a trial', (tester) async {
    await tester.pumpWidget(_harness(const MotionPerceptionScreen(), db));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pump();
    expect(find.text('Watch…'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1600));
  });

  testWidgets('EyeFatigueScreen shows intro then first question', (tester) async {
    await tester.pumpWidget(_harness(const EyeFatigueScreen(), db));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.text('Never'), findsOneWidget);
  });

  testWidgets('TrendsScreen shows empty state with no results', (tester) async {
    await tester.pumpWidget(_harness(const TrendsScreen(), db));
    await tester.pumpAndSettle();
    expect(find.text('No results yet. Complete a test to start building a trend.'), findsOneWidget);
  });

  testWidgets('ProfileScreen shows empty state with no results', (tester) async {
    await tester.pumpWidget(_harness(const ProfileScreen(), db));
    await tester.pumpAndSettle();
    expect(find.text('No results yet. Complete tests to build your profile.'), findsOneWidget);
  });
}
