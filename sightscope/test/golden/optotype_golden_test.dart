import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sightscope/shared/test_engine/widgets/optotype_painter.dart';

void main() {
  testWidgets('Tumbling E optotype golden', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(
          child: ColoredBox(
            color: Colors.white,
            child: OptotypeView(
              shape: OptotypeShape.tumblingE,
              heightPx: 100,
              strokePx: 20,
              orientationDeg: 90,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(OptotypeView),
      matchesGoldenFile('goldens/tumbling_e.png'),
    );
  });

  testWidgets('Landolt C optotype golden', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(
          child: ColoredBox(
            color: Colors.white,
            child: OptotypeView(
              shape: OptotypeShape.landoltC,
              heightPx: 100,
              strokePx: 20,
              orientationDeg: 0,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(OptotypeView),
      matchesGoldenFile('goldens/landolt_c.png'),
    );
  });
}
