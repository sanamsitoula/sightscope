# Peripheral Awareness

## Purpose

Screen the user's ability to detect and localize brief visual events outside central fixation.

## What This Test Measures

Accuracy (and reaction time) for correctly localizing a briefly flashed target presented at a fixed eccentricity in one of four quadrants around a central fixation point.

## Scientific Background

Peripheral/parafoveal vision has lower acuity but is highly sensitive to onset transients (sudden appearance/motion), which is why peripheral detection tasks with brief flashes are a common way to screen functional field awareness without requiring specialized perimetry hardware [needs verification: precise citation for consumer-device peripheral-detection task design]. This is a screening approximation, not clinical visual-field perimetry (e.g. Humphrey/Goldmann), which uses calibrated luminance thresholds across a mapped visual field under controlled conditions.

## Test Protocol

1. Instructions: fixate the central cross throughout; do not look toward the target.
2. Practice trials with an easy, longer flash duration.
3. Main test: a fixed sequence of trials. Each trial shows the fixation cross for a randomized delay, then flashes a small target at a fixed eccentricity in one of four quadrants (up/down/left/right of center) for a brief, fixed duration; the user taps the quadrant they perceived the flash in.
4. Some trials may be catch trials with no flash, to flag guessing (main-phase scoring excludes catch trials from accuracy but records false-positive taps).

## Stimulus Design

The fixation cross and target are drawn with `CustomPaint`/basic widgets. Target eccentricity is expressed as a fraction of the visible screen (not calibrated visual angle in v1.0.0, since this app cannot guarantee gaze position or verify fixation) — this is documented as a limitation rather than presented as a precise perimetric measurement.

## Scoring Method

`accuracy` = fraction of non-catch trials with the correct quadrant response. `metrics['falsePositives']` = taps recorded during catch trials.

## Confidence

Reduced if false positives are high (suggests guessing rather than genuine detection) or if fixation cannot be verified (this app has no way to confirm the user kept central fixation).

## Known Limitations

- Cannot verify actual gaze/fixation — the user could look directly at the target, invalidating the "peripheral" framing. This is a fundamental limitation of a non-eye-tracked screening tool.
- Not equivalent to clinical visual-field perimetry.
- Target eccentricity is relative to screen size, not calibrated visual angle, in this version.

## Potential Confounders

Screen size differences across devices, ambient lighting, user not maintaining fixation, reaction-time variability unrelated to peripheral sensitivity.

## User-Facing Interpretation

"Your result suggests how reliably you noticed events near the edge of your visual field on this device, if you kept looking at the center dot. This is an educational screening task, not a clinical visual-field test, and cannot verify that you maintained fixation."

## References

- General principles of peripheral onset-detection sensitivity are well established in vision-science literature; exact primary sources for this specific task design: [needs verification].
