# Visual Acuity (Tumbling E / Landolt C)

## Purpose

Screen how sharply a user can resolve fine detail at a given distance, per eye, using standardized optotype geometry.

## What This Test Measures

Minimum angle of resolution (MAR), expressed as logMAR and an approximate Snellen-equivalent, for each eye independently.

## Scientific Background

Visual acuity charts present optotypes whose critical detail (e.g. the gap in a Landolt C, or the stroke width of a Tumbling E) subtends a known visual angle at a known viewing distance. The logMAR scale spaces acuity levels in equal logarithmic steps, which is the design principle behind the Bailey–Lovie and ETDRS chart families [needs verification: exact citation]. A logMAR of 0.0 corresponds to a 1-arcminute minimum angle of resolution (the traditional "20/20" / "6/6" reference), and each optotype's full height subtends 5× that critical angle — the classic 5-arcminute design used across most logMAR and Snellen-style charts.

The Landolt C (a ring with a gap in one of several positions) and the Tumbling E (a letter E rotated in one of four orientations) are both forced-choice optotypes: the user reports gap/arm orientation rather than reading a specific letter, which avoids literacy and font-familiarity confounds. Both are long-established, non-copyrighted optotype forms.

## Test Protocol

1. Complete calibration (credit-card PPI) and viewing-distance setup before starting.
2. Practice round at an easy logMAR level (0.5) with feedback, using both optotypes' interaction pattern.
3. Main test: one eye at a time (the other covered by the user), using a simple adaptive staircase:
   - Start at logMAR 0.5.
   - Two consecutive correct responses at a level → step to a smaller logMAR (harder) by 0.1.
   - One incorrect response → step to a larger logMAR (easier) by 0.1.
   - Terminate after a fixed number of reversals (4) or a trial cap (14 trials), whichever comes first.
   - Final threshold = mean logMAR of the last 4 reversal points.
4. Repeat for the second eye if the user opts for per-eye testing.

## Stimulus Design

Every optotype is generated through `OptotypeSizing.geometry()`, which derives height/stroke/gap in arcminutes from the logMAR level, converts to millimetres via `VisualAngle.sizeMm`, and to pixels via `CalibrationMath.mmToPixels` using the session's calibrated PPI. No pixel size is ever hardcoded. Optotypes are drawn with `CustomPaint` — the Tumbling E as a bitmap-style stroke path, the Landolt C as a ring with a gap wedge — at four (E) or eight (C) discrete orientations chosen pseudo-randomly per trial.

## Scoring Method

- `logMAR` threshold = mean of the last 4 staircase reversal logMAR values (deterministic given the fixed response sequence).
- `decimalAcuity` = 1 / 10^logMAR (via `OptotypeSizing.decimalAcuity`).
- `accuracy` = fraction of correct responses across the whole main-phase trial set.

## Confidence

- High: staircase reached ≥4 reversals within the trial cap and calibration confidence was high (card-based).
- Medium: staircase reached ≥4 reversals but calibration was device-default.
- Low: trial cap reached without 4 reversals, or calibration confidence was low/fallback.

## Known Limitations

- Not a substitute for a clinical Snellen/ETDRS exam performed by an eye-care professional.
- Screen glare, ambient lighting, screen brightness/contrast settings, and user distance discipline all affect the result.
- Adaptive staircases with few reversals have wider confidence intervals than long clinical charts.

## Potential Confounders

Viewing distance drift during the test, incorrect eye occlusion, screen protectors/glare, corrected vs. uncorrected vision mismatch with the user's stated `correctionUsed`.

## User-Facing Interpretation

"Your result on this screening task suggests a resolution threshold of approximately logMAR X (~decimal Y). This is a screening estimate, not a clinical visual acuity measurement, and should not be interpreted as a diagnosis or prescription. If you have concerns about your vision, consider discussing this result with a qualified eye-care professional."

## References

- Bailey IL, Lovie JE. "New design principles for visual acuity letter charts." *Optom Vis Sci*, 1976. [needs verification]
- Ferris FL et al. "New visual acuity charts for clinical research." *Am J Ophthalmol*, 1982 (ETDRS chart design). [needs verification]
- General logMAR/optotype geometry conventions (5:1 height-to-stroke ratio, 1 arcmin critical detail at 20/20) are widely documented across vision-science literature; exact primary sources should be verified before citing in any public-facing material.
