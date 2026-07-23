import 'package:flutter/material.dart';

import '../../shared/test_engine/screens/staircase_optotype_flow_screen.dart';
import '../visual_acuity/acuity_test_definition.dart';

class NearVisionScreen extends StatelessWidget {
  const NearVisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaircaseOptotypeFlowScreen(
      definitionBuilder: ({required viewingDistanceMm, required ppi}) => AcuityTestDefinition(
        id: 'near_vision',
        version: '1.0.0',
        title: 'Near Vision & Reading',
        shortDescription: 'Screens comfortable reading print size at a near distance.',
        // Near vision always uses the standard ~40cm reading distance,
        // regardless of the distance-testing calibration default.
        viewingDistanceMm: 400,
        ppi: ppi,
      ),
      introText:
          'This screening test measures the smallest print size you can comfortably read at a '
          'normal reading distance (about 40cm). Wear your usual reading correction if you '
          'have one.',
      limitationsText:
          'This is a screening estimate, not a clinical near-vision or presbyopia diagnosis.',
    );
  }
}
