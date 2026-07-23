# Contrast Sensitivity

## Purpose

Screen the user's ability to detect optotypes of fixed size but diminishing contrast against the background.

## What This Test Measures

An approximate contrast sensitivity threshold, expressed as log contrast sensitivity (the negative log10 of the Weber/luminance contrast at which the optotype is no longer reliably identified).

## Scientific Background

Contrast sensitivity testing (e.g., the Pelli-Robson chart) holds optotype size constant (at a size well above the acuity threshold) while progressively reducing contrast between letter and background, measuring the point at which detection fails. This captures visual function not measured by high-contrast acuity charts alone [needs verification: precise citation for Pelli-Robson methodology].

## Test Protocol

1. Calibration + standard viewing distance guidance + lighting guidance (contrast results are especially lighting-sensitive).
2. Practice round at high contrast (90%) with feedback.
3. Main test: fixed-size Tumbling E optotype (sized well above the user's practice-round acuity so size is never the limiting factor), presented at decreasing Weber contrast using the same staircase pattern as visual acuity:
   - Start at 50% contrast.
   - Two consecutive correct → reduce contrast by a fixed log step.
   - One incorrect → increase contrast by a fixed log step.
   - Terminate at 4 reversals or a 14-trial cap.
4. Threshold = mean contrast (converted to log sensitivity) of the last 4 reversals.

## Stimulus Design

Optotype geometry (size only) still flows through `OptotypeSizing.geometry()` at a fixed, generously large logMAR so size never becomes the bottleneck. Contrast is applied purely as a rendering-layer alpha/color blend between `AppColors.stimulusInk` and `AppColors.stimulusPaper` in the `CustomPaint` layer — never as a change to physical stimulus size, keeping the single calibration utility authoritative for sizing only.

## Scoring Method

`logCS = -log10(weberContrastAtThreshold)`, where `weberContrastAtThreshold` is the mean of the last 4 staircase-reversal contrast fractions (0..1). `accuracy` is the fraction of correct responses across the main phase.

## Confidence

Same convergence + calibration-confidence bucketing as visual acuity, plus a lighting caveat always included in `reasons` since ambient light materially affects apparent contrast on a self-luminous screen.

## Known Limitations

- Screen brightness, auto-brightness/adaptive color, and ambient glare all directly affect measured contrast — much more so than for high-contrast acuity.
- Not equivalent to a printed Pelli-Robson chart under controlled illuminance.

## Potential Confounders

Auto-brightness changes mid-test, screen protectors, ambient glare, display calibration differences across devices.

## User-Facing Interpretation

"Your result suggests a contrast sensitivity screening score of approximately X. This score is strongly affected by your screen's brightness and the room's lighting, so it should not be compared to results measured on a different device or in different lighting, and is not a clinical contrast sensitivity diagnosis."

## References

- Pelli DG, Robson JG, Wilkins AJ. "The design of a new letter chart for measuring contrast sensitivity." *Clin Vis Sci*, 1988. [needs verification]
