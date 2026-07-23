import 'package:go_router/go_router.dart';

import '../../shared/test_engine/dummy/dummy_test_screen.dart';
import 'home_placeholder_screen.dart';

/// Phase-0 router: just enough to host the engine-demo screen. Feature
/// routes are added starting in Phase 1.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePlaceholderScreen()),
    GoRoute(path: '/dummy-test', builder: (context, state) => const DummyTestScreen()),
  ],
);
