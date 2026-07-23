import 'package:flutter/foundation.dart';

import '../../models/enums.dart';

/// Environment/device metadata captured for a session, independent of any
/// single test's logic. Mirrors the device-related fields of §19.
@immutable
class TestDeviceContext {
  const TestDeviceContext({
    required this.deviceModel,
    required this.screenSize,
    required this.screenDensity,
    this.brightnessIfAvailable,
    this.viewingDistanceMm,
    this.eyeTested = Eye.both,
    this.correctionUsed = CorrectionUsed.unknown,
    this.environmentNotes,
  });

  final String deviceModel;
  final String screenSize;

  /// True PPI from calibration.
  final double screenDensity;
  final double? brightnessIfAvailable;
  final double? viewingDistanceMm;
  final Eye eyeTested;
  final CorrectionUsed correctionUsed;
  final String? environmentNotes;
}
