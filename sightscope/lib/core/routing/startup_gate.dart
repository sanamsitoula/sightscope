import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/home_dashboard_screen.dart';
import '../../features/onboarding/disclaimer_screen.dart';
import '../calibration/calibration_provider.dart';

/// Gates the app behind the first-launch disclaimer (Task.md §15 / spec.md
/// Gate 1). Nothing else in the app is reachable until this is accepted.
class StartupGate extends ConsumerStatefulWidget {
  const StartupGate({super.key});

  @override
  ConsumerState<StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends ConsumerState<StartupGate> {
  bool? _accepted;

  @override
  void initState() {
    super.initState();
    ref.read(securePrefsProvider).getDisclaimerAccepted().then((value) {
      if (mounted) setState(() => _accepted = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_accepted == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_accepted == false) {
      return DisclaimerScreen(onAccepted: () => setState(() => _accepted = true));
    }
    return const HomeDashboardScreen();
  }
}
