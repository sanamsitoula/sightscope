import 'package:flutter/foundation.dart';

/// Recommended viewing distances for SightScope tests (educational guidance).
@immutable
class ViewingDistance {
  const ViewingDistance({
    required this.mm,
    required this.label,
    required this.instructions,
  });

  final double mm;
  final String label;
  final String instructions;

  /// Typical near/distance-screening distance for a handheld test.
  static const ViewingDistance standardHandheld = ViewingDistance(
    mm: 400,
    label: '~40 cm (about an arm\'s length)',
    instructions:
        'Hold the phone about 40 cm from your eyes — roughly a comfortable '
        'arm\'s length. Keep the screen at eye level and perpendicular to your '
        'gaze.',
  );

  static const ViewingDistance nearReading = ViewingDistance(
    mm: 400,
    label: '~40 cm reading distance',
    instructions:
        'Hold the screen at your normal reading distance (around 40 cm). '
        'If you use reading glasses for near work, wear them.',
  );
}
