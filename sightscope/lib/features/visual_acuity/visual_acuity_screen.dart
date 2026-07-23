import 'package:flutter/material.dart';

import '../../shared/test_engine/screens/staircase_optotype_flow_screen.dart';
import 'acuity_test_definition.dart';

class VisualAcuityScreen extends StatelessWidget {
  const VisualAcuityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaircaseOptotypeFlowScreen(
      definitionBuilder: ({required viewingDistanceMm, required ppi}) => AcuityTestDefinition(
        id: 'visual_acuity',
        version: '1.0.0',
        title: 'Visual Acuity',
        shortDescription: 'Screens how sharply you can resolve fine detail.',
        viewingDistanceMm: viewingDistanceMm,
        ppi: ppi,
      ),
      introText:
          'This screening test measures how small a shape you can reliably identify at your '
          'current viewing distance. Hold your device steady and keep it at a comfortable, '
          'consistent distance throughout the test.',
      limitationsText:
          'This is a screening estimate, not a clinical visual acuity measurement. It should '
          'not be interpreted as a diagnosis or prescription.',
    );
  }
}
