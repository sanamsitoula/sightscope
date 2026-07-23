import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sightscope/main.dart';

void main() {
  testWidgets('App boots to the home placeholder screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SightScopeApp()));
    await tester.pumpAndSettle();

    expect(find.text('SightScope'), findsOneWidget);
    expect(find.text('Run engine demo'), findsOneWidget);
  });

  testWidgets('Navigating to the engine demo shows the run button', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SightScopeApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Run engine demo'));
    await tester.pumpAndSettle();

    expect(find.text('Run full flow'), findsOneWidget);
  });
}
