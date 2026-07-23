# Color Perception

## Purpose

Screen for indications of red-green color vision differences using original, procedurally generated dot-pattern plates.

## What This Test Measures

Whether the user can identify a simple shape (not a specific number, to avoid needing font/character-recognition parity with any existing commercial test) embedded in a field of colored dots, across a small set of procedurally generated red-green confusion-line color pairs.

## Scientific Background

Pseudoisochromatic plate tests work by embedding a figure using colors that differ mainly along a "confusion line" in color space that corresponds to specific cone-deficiency types (protan/deutan), while keeping luminance and dot texture similar across figure and background so the figure is not distinguishable by brightness alone. SightScope's plates are original: dot positions, sizes, and the embedded shape are generated procedurally at runtime (never a bundled bitmap), and color pairs are chosen from generic red-green confusion-line approximations rather than reproducing any specific commercial plate's published colors [needs verification: exact confusion-line color coordinates used should be validated against colorimetric literature before being treated as clinically indicative].

## Test Protocol

1. Brief instructions: identify the embedded shape (circle, triangle, square, or "none visible") from a fixed set of choices.
2. Practice plate with a high, easy-to-see color difference.
3. Main test: a fixed sequence of plates spanning easy → subtle red-green color differences, using normal (non-adaptive) trial-by-trial scoring — this screen is a flag/no-flag indicator, not a staircase threshold.
4. Result reports the fraction of subtle plates correctly identified, not a diagnosis of deficiency type or severity.

## Stimulus Design

Each plate is generated with `CustomPaint`: a fixed canvas is tiled with randomly placed, randomly sized dots (seeded per-plate for reproducibility within a session) in a background hue, with a subset of dots inside the target shape's silhouette recolored to a foreground hue chosen along an approximate red-green confusion line at a specified color-distance step. No dot-plate image assets are bundled or reused from any existing test.

## Scoring Method

`accuracy` = fraction of main-phase plates correctly identified. `metrics['subtleAccuracy']` = accuracy restricted to the two most subtle (hardest) plates, which is the more informative flag for potential color-vision difference.

## Confidence

- Medium by default (this is a screening flag, not a diagnostic anomaloscope test).
- Reduced if the device's display characteristics are unknown (color rendering varies significantly across screens, unlike grayscale contrast).

## Known Limitations

- Cannot classify deficiency type (protanopia vs. deuteranopia vs. anomalous trichromacy) or severity.
- Consumer display color calibration varies significantly device-to-device; results are not comparable across devices.
- Not validated against any clinical color-vision instrument.

## Potential Confounders

Display color profile/calibration, ambient lighting color temperature, screen brightness, colorblind-assist OS-level filters if enabled.

## User-Facing Interpretation

"Your responses to these color-pattern screening plates suggest [no notable difficulty / some difficulty] with distinguishing certain red-green color differences on this screen. This is an educational screening pattern, not a clinical color-vision diagnosis, and cannot determine a specific type of color-vision difference. Display color rendering varies by device. If you have concerns, a comprehensive color-vision test from a qualified eye-care professional is the appropriate next step."

## References

- General pseudoisochromatic-plate design principles (confusion-line color selection, luminance/texture matching to prevent brightness-based solving) are described across color-vision literature. Exact primary sources and confusion-line coordinates: [needs verification].
