# Motion Perception (Coherent Motion / Random-Dot Kinematogram)

## Purpose

Screen sensitivity to coherent visual motion using a random-dot kinematogram (RDK).

## What This Test Measures

The minimum motion coherence (the fraction of dots moving in a common direction, versus randomly repositioned "noise" dots) at which the user can reliably report the overall direction of motion.

## Scientific Background

Random-dot kinematograms are a classic paradigm for studying motion perception: a field of dots is shown where some fraction move coherently in one direction while the rest are randomly repositioned each frame ("noise"), and the observer reports the perceived direction of coherent motion. Coherence threshold is a well-established measure of motion sensitivity tied to the dorsal visual stream / area MT (V5) processing [needs verification: precise citation, e.g. Newsome & Paré 1988]. SightScope uses a simplified two-alternative (left/right) direction-discrimination version with an adaptive coherence staircase.

## Test Protocol

1. Instructions: watch the moving dots and indicate whether they are moving mostly left or mostly right.
2. Practice trial at high coherence (90%) with feedback.
3. Main test: an adaptive 2-down/1-up coherence staircase (same mechanism as `Staircase`, harder = lower coherence), each trial displaying ~1.5s of animated dots at the current coherence and a randomized left/right direction; the user taps left or right.
4. Threshold = mean coherence of the last 4 staircase reversals.

## Stimulus Design

Dots are drawn with `CustomPaint`, animated via an `AnimationController`/ticker updating dot positions each frame at a fixed dot count and speed. Coherence controls the fraction of dots that move consistently in the trial's direction each frame; the remainder are given random new positions each frame (standard "random position" RDK noise algorithm). Dot size/speed are screen-relative in v1.0.0, not calibrated visual angle (this test is about motion coherence sensitivity, not spatial acuity).

## Scoring Method

`score` = coherence threshold (0..1, lower = more sensitive). `accuracy` = fraction of correct direction responses across the main phase.

## Confidence

Same convergence-based bucketing as the acuity/contrast staircases (Task.md engine pattern): high if the staircase reached its full reversal count, reduced otherwise.

## Known Limitations

- This animation inherently involves motion; users with motion sensitivity or vestibular concerns, or with reduced-motion accessibility settings enabled, should be aware before starting (see Accessibility notes — this test cannot be meaningfully redesigned as static and still measure motion perception).
- Dot count/speed/size are not calibrated to visual angle in v1.0.0, so results are not comparable across very different screen sizes.
- Not a validated clinical motion-perception assessment.

## Potential Confounders

Screen refresh rate differences across devices, frame-rate drops under load, general processing-speed/attention effects unrelated to motion sensitivity specifically.

## User-Facing Interpretation

"Your result suggests the level of coherent motion you could reliably detect on this screening task. This is an educational self-assessment, not a diagnostic measurement of motion perception or visual processing."

## References

- Newsome WT, Paré EB. "A selective impairment of motion perception following lesions of the middle temporal visual area (MT)." *J Neurosci*, 1988 (coherent motion / RDK paradigm origin). [needs verification]
