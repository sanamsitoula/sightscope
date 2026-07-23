# Near Vision & Reading

## Purpose

Screen near-vision acuity and comfortable reading print size at a typical reading distance.

## What This Test Measures

The smallest print size (expressed in logMAR-equivalent near-vision notation, derived the same way as distance acuity but at a near viewing distance) at which the user can reliably identify short forced-choice optotype rows.

## Scientific Background

Near-vision assessment uses the same visual-angle geometry as distance acuity, but at a near viewing distance (typically ~40cm) reflecting normal reading posture. Reduced near acuity relative to distance acuity, or difficulty at typical reading distance, is commonly associated with presbyopia and uncorrected refractive error in adults [needs verification: precise clinical framing/citation].

## Test Protocol

1. Calibration + near viewing-distance guidance (`ViewingDistance.nearReading`, ~40cm) shown before starting; the user is asked to wear their usual reading correction if any.
2. Practice round at an easy near-logMAR level.
3. Main test: the same adaptive staircase design as visual acuity (§ visual_acuity.md), reusing `OptotypeSizing` with the near viewing distance instead of distance-testing.
4. Single combined-eyes pass by default; per-eye is available via the same engine flow as visual acuity.

## Stimulus Design

Identical geometry pipeline to visual acuity — `OptotypeSizing.geometry()` — but with `viewingDistanceMm` set from `ViewingDistance.nearReading` (~400mm) rather than a longer distance-testing setup. No separate physical-size math is created; this test reuses the single calibration utility.

## Scoring Method

Same staircase-reversal-mean logMAR scoring as visual acuity, computed independently and stored under a distinct `testId` (`near_vision`) so distance and near results never mix.

## Confidence

Same confidence bucketing as visual acuity: staircase convergence + calibration confidence.

## Known Limitations

- Does not account for accommodation dynamics or measure amplitude of accommodation.
- Sensitive to the user's actual reading posture/distance, which the app cannot verify.

## Potential Confounders

Reading glasses not worn when normally used, poor lighting, screen size differences across devices affecting comfortable holding distance.

## User-Facing Interpretation

"Your near-vision screening result suggests a comfortable reading threshold of approximately logMAR X at a ~40cm distance. This is an educational screening estimate, not a clinical near-vision or presbyopia diagnosis."

## References

- Near-vision testing at standardized ~40cm distance is a widely used clinical convention (e.g. near-vision reading charts). Exact primary source: [needs verification].
