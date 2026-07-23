import 'package:go_router/go_router.dart';

import '../../features/color_vision/color_vision_screen.dart';
import '../../features/contrast_sensitivity/contrast_sensitivity_screen.dart';
import '../../features/education/education_screen.dart';
import '../../features/eye_fatigue/eye_fatigue_screen.dart';
import '../../features/eye_wellness/presentation/eye_wellness_dashboard.dart';
import '../../features/eye_wellness/presentation/eye_wellness_settings_screen.dart';
import '../../features/eye_wellness/presentation/one_minute_reset_screen.dart';
import '../../features/history/history_screen.dart';
import '../../features/motion_perception/motion_perception_screen.dart';
import '../../features/near_vision/near_vision_screen.dart';
import '../../features/onboarding/calibration_screen.dart';
import '../../features/peripheral_vision/peripheral_vision_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/reaction_time/reaction_time_screen.dart';
import '../../features/stereo_vision/depth_perception_screen.dart';
import '../../features/trends/trends_screen.dart';
import '../../features/visual_acuity/visual_acuity_screen.dart';
import '../../features/visual_attention/visual_attention_screen.dart';
import '../../features/visual_memory/visual_memory_screen.dart';
import '../../shared/test_engine/dummy/dummy_test_screen.dart';
import 'startup_gate.dart';

/// App-wide routes (Task.md §14/§16). '/' is gated behind the first-launch
/// disclaimer via [StartupGate].
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const StartupGate()),
    GoRoute(path: '/calibration', builder: (context, state) => const CalibrationScreen()),
    GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
    GoRoute(path: '/education', builder: (context, state) => const EducationScreen()),
    GoRoute(path: '/trends', builder: (context, state) => const TrendsScreen()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
    GoRoute(path: '/tests/visual-acuity', builder: (context, state) => const VisualAcuityScreen()),
    GoRoute(path: '/tests/near-vision', builder: (context, state) => const NearVisionScreen()),
    GoRoute(
      path: '/tests/contrast-sensitivity',
      builder: (context, state) => const ContrastSensitivityScreen(),
    ),
    GoRoute(path: '/tests/color-vision', builder: (context, state) => const ColorVisionScreen()),
    GoRoute(path: '/tests/reaction-time', builder: (context, state) => const ReactionTimeScreen()),
    GoRoute(
      path: '/tests/depth-perception',
      builder: (context, state) => const DepthPerceptionScreen(),
    ),
    GoRoute(
      path: '/tests/peripheral-vision',
      builder: (context, state) => const PeripheralVisionScreen(),
    ),
    GoRoute(
      path: '/tests/visual-attention',
      builder: (context, state) => const VisualAttentionScreen(),
    ),
    GoRoute(path: '/tests/visual-memory', builder: (context, state) => const VisualMemoryScreen()),
    GoRoute(
      path: '/tests/motion-perception',
      builder: (context, state) => const MotionPerceptionScreen(),
    ),
    GoRoute(path: '/tests/eye-fatigue', builder: (context, state) => const EyeFatigueScreen()),
    GoRoute(path: '/eye-wellness', builder: (context, state) => const EyeWellnessDashboard()),
    GoRoute(
      path: '/eye-wellness/reset',
      builder: (context, state) => const OneMinuteResetScreen(),
    ),
    GoRoute(
      path: '/eye-wellness/settings',
      builder: (context, state) => const EyeWellnessSettingsScreen(),
    ),
    GoRoute(path: '/dummy-test', builder: (context, state) => const DummyTestScreen()),
  ],
);
