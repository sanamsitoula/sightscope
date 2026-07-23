# Visual Attention (Visual Search)

## Purpose

Screen visual search efficiency: how quickly and accurately the user can locate a target that differs from surrounding distractors.

## What This Test Measures

Accuracy and reaction time for locating a color-odd-one-out target among an increasing number of distractors.

## Scientific Background

Visual search tasks are a standard paradigm for studying selective visual attention. Search time for a target that differs from distractors by a single salient feature (like color) is typically fast and largely unaffected by the number of distractors ("feature search" / parallel search), whereas search requiring a conjunction of features tends to slow down as distractor count increases ("serial search") [needs verification: precise citation, e.g. Treisman's feature integration theory]. SightScope's v1.0.0 attention task uses a single-feature (color) search to keep the task unambiguous and quick to administer; increasing distractor count is used mainly to check for a consistent, non-degrading response pattern rather than to diagnose a search-slope deficit.

## Test Protocol

1. Instructions: tap the shape that is a different color from the rest, as quickly and accurately as you can.
2. Practice trials with few distractors.
3. Main test: a fixed sequence of trials with increasing distractor counts (e.g. 4, 8, 12 total shapes), two repetitions each, target color/position randomized per trial.

## Stimulus Design

A grid of colored circles is drawn with basic `CustomPaint`/`Container` widgets at randomized grid positions; exactly one circle is a different, clearly distinguishable color. Layout is screen-relative, not calibrated visual angle (this test is about search/attention, not spatial acuity).

## Scoring Method

`accuracy` = fraction of trials with a correct tap. `metrics['meanRtBySetSize']` records mean reaction time per distractor-count tier, letting the result screen show whether response time held steady or grew with more distractors.

## Confidence

Reduced if accuracy is low across all set sizes (suggests inattention or task misunderstanding, not necessarily reduced search ability) or if trial count is small.

## Known Limitations

- Single-feature (color) search only; does not screen conjunction/serial search, which is more attention-demanding.
- Device touch-input latency is not calibrated out of reaction-time figures.
- Not a validated clinical attention or ADHD screening instrument.

## Potential Confounders

Color-vision differences (a color-based search task is harder if the user has difficulty distinguishing the target/distractor colors — cross-reference with the Color Perception test), screen size, distraction, fatigue.

## User-Facing Interpretation

"Your result suggests how quickly and accurately you located a colored target among distractors on this task. This is an educational screening measure of visual search performance, not a diagnostic attention or cognitive assessment."

## References

- Visual search / feature-integration theory concepts are well established in cognitive psychology (e.g. Treisman & Gelade). Exact citation: [needs verification].
