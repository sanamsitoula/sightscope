import 'package:flutter/foundation.dart';

/// Geometric description of a calibrated 5-part optotype (Tumbling E, Landolt C,
/// Sloan letter) for a single logMAR line at a fixed viewing distance and PPI.
///
/// The critical detail (stroke/gap) subtends 1×MAR; the full optotype height
/// subtends 5×MAR. At logMAR 0 (20/20) this yields the classic 5-arcmin
/// optotype with a 1-arcmin critical detail.
@immutable
class OptotypeGeometry {
  const OptotypeGeometry({
    required this.logMAR,
    required this.marArcmin,
    required this.heightArcmin,
    required this.strokeArcmin,
    required this.gapArcmin,
    required this.heightMm,
    required this.strokeMm,
    required this.gapMm,
    required this.heightPx,
    required this.strokePx,
    required this.gapPx,
    required this.viewingDistanceMm,
    required this.ppi,
  });

  final double logMAR;
  final double marArcmin;
  final double heightArcmin;
  final double strokeArcmin;
  final double gapArcmin;
  final double heightMm;
  final double strokeMm;
  final double gapMm;
  final double heightPx;
  final double strokePx;
  final double gapPx;
  final double viewingDistanceMm;
  final double ppi;
}
