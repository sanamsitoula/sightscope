import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/home_dashboard_screen.dart';
import '../../features/onboarding/data_permission_screen.dart';
import '../../features/onboarding/disclaimer_screen.dart';
import '../calibration/calibration_provider.dart';

enum _OnboardingStep { loading, disclaimer, dataPermission, done }

/// Gates the app behind two first-launch steps, in order (Task.md §15 /
/// spec.md Gate 1): the non-diagnostic disclaimer, then the data-collection
/// consent screen. Nothing else in the app is reachable until both are
/// accepted.
class StartupGate extends ConsumerStatefulWidget {
  const StartupGate({super.key});

  @override
  ConsumerState<StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends ConsumerState<StartupGate> {
  _OnboardingStep _step = _OnboardingStep.loading;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = ref.read(securePrefsProvider);
    final bool disclaimerAccepted = await prefs.getDisclaimerAccepted();
    if (!disclaimerAccepted) {
      if (mounted) setState(() => _step = _OnboardingStep.disclaimer);
      return;
    }
    final bool dataAccepted = await prefs.getDataCollectionAccepted();
    if (!dataAccepted) {
      if (mounted) setState(() => _step = _OnboardingStep.dataPermission);
      return;
    }
    if (mounted) setState(() => _step = _OnboardingStep.done);
  }

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case _OnboardingStep.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case _OnboardingStep.disclaimer:
        return DisclaimerScreen(
          onAccepted: () => setState(() => _step = _OnboardingStep.dataPermission),
        );
      case _OnboardingStep.dataPermission:
        return DataPermissionScreen(
          onAllowed: () => setState(() => _step = _OnboardingStep.done),
        );
      case _OnboardingStep.done:
        return const HomeDashboardScreen();
    }
  }
}
