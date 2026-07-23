import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sightscope/core/calibration/calibration_provider.dart';
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
    await tester.pumpWidget(ProviderScope(
      overrides: [securePrefsProvider.overrideWithValue(SecurePrefs(InMemoryKeyValueStore()))],
      child: const SightScopeApp(),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('disclaimer_accept_button')));
    await tester.pumpAndSettle();

    expect(find.text('Visual Acuity'), findsOneWidget);
    expect(find.text('Contrast Sensitivity'), findsOneWidget);
    expect(find.text('Color Perception'), findsOneWidget);
    expect(find.text('Reaction Time'), findsOneWidget);
  });
}
