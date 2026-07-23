# Visual Memory (Change Detection)

## Purpose

Screen short-term visual working memory capacity using a standard change-detection paradigm.

## What This Test Measures

Accuracy at detecting whether a single item's color changed between two brief views of a small array of colored squares, across increasing array (set) sizes.

## Scientific Background

The change-detection paradigm — briefly show an array, hide it, then show it again with or without one item changed — is a widely used way to estimate visual working-memory capacity. A common summary statistic is Cowan's K, an estimate of the number of items held in memory derived from hit and false-alarm rates at a given set size [needs verification: exact formula/citation, e.g. Cowan 2001; Pashler 1988]. SightScope reports raw accuracy per set size as the primary, most transparent metric, and includes an approximate K estimate as a secondary, clearly-labeled metric rather than the headline score.

## Test Protocol

1. Instructions: remember the colored squares; after they disappear and reappear, say whether one changed color.
2. Practice trial with a small set size (2 items).
3. Main test: a fixed sequence of trials at increasing set sizes (3, 4, 5 items), two trials each — one "same" and one "changed" per set size — presented for a fixed study time (1.5s), a blank retention interval (1.0s), then the test array until response.

## Stimulus Design

Colored squares are drawn with basic `Container`/`CustomPaint` widgets at randomized non-overlapping grid positions. Size/spacing is screen-relative, not calibrated visual angle (this test is about memory capacity, not spatial acuity).

## Scoring Method

`accuracy` = fraction of correct same/changed judgments. `metrics['approxK']` = an approximate Cowan's K computed as `setSize × (hitRate + correctRejectionRate − 1)`, averaged across set sizes with both a "same" and "changed" trial — reported as an approximation, not a precise clinical memory-span score.

## Confidence

Reduced if accuracy is near chance (50%) at the smallest set size, which suggests task misunderstanding rather than genuine low capacity.

## Known Limitations

- Very small number of trials per set size (screening-length, not a full psychophysical memory-span assessment) — the K estimate has wide uncertainty.
- Not a validated clinical working-memory or cognitive assessment.
- Color-based stimuli interact with color-vision differences.

## Potential Confounders

Distraction during the retention interval, screen brightness/color rendering, fatigue, practice effects across repeated sessions.

## User-Facing Interpretation

"Your result suggests how many colored items you could briefly hold in mind on this short screening task. This is an educational self-assessment, not a diagnostic memory or cognitive test, and the small number of trials means the estimate is approximate."

## References

- Change-detection working-memory paradigm and Cowan's K: Cowan N. "The magical number 4 in short-term memory." *Behav Brain Sci*, 2001. [needs verification]
