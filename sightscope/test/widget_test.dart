import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sightscope/core/calibration/calibration_provider.dart';
import 'package:sightscope/core/storage/database.dart';
import 'package:sightscope/core/storage/database_provider.dart';
import 'package:sightscope/core/storage/secure_prefs.dart';
import 'package:sightscope/main.dart';

void main() {
  testWidgets('First launch shows the disclaimer gate, not the dashboard', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [securePrefsProvider.overrideWithValue(SecurePrefs(InMemoryKeyValueStore()))],
      child: const SightScopeApp(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Before you begin'), findsOneWidget);
  });

  testWidgets('Accepting the disclaimer reveals the home dashboard', (tester) async {
    // Tall enough that every dashboard row is built by the sliver list, not
    // just what fits in the default 800x600 test viewport.
    tester.view.physicalSize = const Size(1080, 3200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = AppDatabase.forTesting();
    addTearDown(db.close);
    await tester.pumpWidget(ProviderScope(
      overrides: [
        securePrefsProvider.overrideWithValue(SecurePrefs(InMemoryKeyValueStore())),
        appDatabaseProvider.overrideWithValue(db),
      ],
      child: const SightScopeApp(),
    ));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('disclaimer_accept_button')));
    await tester.tap(find.byKey(const Key('disclaimer_accept_button')));
    await tester.pumpAndSettle();

    expect(find.text('Visual Acuity'), findsOneWidget);
    expect(find.text('Contrast Sensitivity'), findsOneWidget);
    expect(find.text('Color Perception'), findsOneWidget);
    expect(find.text('Reaction Time'), findsOneWidget);
  });
}
