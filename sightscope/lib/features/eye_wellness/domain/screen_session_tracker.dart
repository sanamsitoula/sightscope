import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks continuous *in-app* foreground time — how long SightScope itself
/// has been open without being backgrounded.
///
/// This is intentionally scoped to SightScope's own foreground time, not
/// system-wide screen time. Reading which other apps the user has open
/// (e.g. "You spent 42 minutes on YouTube") requires OS-level usage-access
/// APIs that are either permission- and dependency-gated (Android
/// `PACKAGE_USAGE_STATS`) or not available to third-party apps at all
/// (iOS has no public API for this). Neither is implemented here — see
/// docs/brand.md's EyeGuard section for the scope decision.
class ScreenSessionNotifier extends Notifier<Duration> with WidgetsBindingObserver {
  Timer? _ticker;
  DateTime? _sessionStartedAt;

  @override
  Duration build() {
    WidgetsBinding.instance.addObserver(this);
    _beginSession();
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
      _ticker?.cancel();
    });
    return Duration.zero;
  }

  void _beginSession() {
    _sessionStartedAt = DateTime.now();
    state = Duration.zero;
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final DateTime? start = _sessionStartedAt;
      if (start != null) {
        state = DateTime.now().difference(start);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    switch (lifecycleState) {
      case AppLifecycleState.resumed:
        _beginSession();
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _ticker?.cancel();
    }
  }

  /// Called after the user completes or dismisses a reminder/exercise so
  /// the same continuous session doesn't immediately re-trigger.
  void resetSession() => _beginSession();
}

final NotifierProvider<ScreenSessionNotifier, Duration> screenSessionProvider =
    NotifierProvider<ScreenSessionNotifier, Duration>(ScreenSessionNotifier.new);
