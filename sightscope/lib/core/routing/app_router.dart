import 'package:go_router/go_router.dart';

import '../../features/color_vision/color_vision_screen.dart';
import '../../features/contrast_sensitivity/contrast_sensitivity_screen.dart';
import '../../features/education/education_screen.dart';
import '../../features/history/history_screen.dart';
import '../../features/near_vision/near_vision_screen.dart';
import '../../features/onboarding/calibration_screen.dart';
import '../../features/reaction_time/reaction_time_screen.dart';
import '../../features/visual_acuity/visual_acuity_screen.dart';
import '../../shared/test_engine/dummy/dummy_test_screen.dart';
import 'startup_gate.dart';

/// App-wide routes (Task.md §14). '/' is gated behind the first-launch
/// disclaimer via [StartupGate].
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const StartupGate()),
    GoRoute(path: '/calibration', builder: (context, state) => const CalibrationScreen()),
    GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
    GoRoute(path: '/education', builder: (context, state) => const EducationScreen()),
    GoRoute(path: '/tests/visual-acuity', builder: (context, state) => const VisualAcuityScreen()),
    GoRoute(path: '/tests/near-vision', builder: (context, state) => const NearVisionScreen()),
    GoRoute(
      path: '/tests/contrast-sensitivity',
      builder: (context, state) => const ContrastSensitivityScreen(),
    ),
    GoRoute(path: '/tests/color-vision', builder: (context, state) => const ColorVisionScreen()),
    GoRoute(path: '/tests/reaction-time', builder: (context, state) => const ReactionTimeScreen()),
    GoRoute(path: '/dummy-test', builder: (context, state) => const DummyTestScreen()),
  ],
);
