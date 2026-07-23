import 'package:flutter/material.dart';

import '../../shared/test_engine/screens/staircase_optotype_flow_screen.dart';
import 'contrast_sensitivity_test_definition.dart';

class ContrastSensitivityScreen extends StatelessWidget {
  const ContrastSensitivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaircaseOptotypeFlowScreen(
      testId: 'contrast_sensitivity',
      title: 'Contrast Sensitivity',
      definitionBuilder: ({required viewingDistanceMm, required ppi}) =>
          ContrastSensitivityTestDefinition(viewingDistanceMm: viewingDistanceMm, ppi: ppi),
      introText:
          'This screening test measures how faint a shape can be while you can still reliably '
          'see it. The shape stays the same size — only its contrast changes. Use even, '
          'consistent room lighting.',
      limitationsText:
          'This is a screening estimate, strongly affected by your screen brightness and room '
          'lighting. Do not compare this result across different devices or lighting.',
    );
  }
}
