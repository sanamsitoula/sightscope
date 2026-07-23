# Reaction Time

## Purpose

Screen simple visual-motor reaction time: the latency between a visual stimulus appearing and the user responding.

## What This Test Measures

Mean and variability of simple reaction time (ms) to an unpredictable visual onset, with catch trials to discourage anticipatory responses.

## Scientific Background

Simple reaction time (respond as fast as possible to a single, unambiguous stimulus) is a widely used basic measure of visual-motor processing speed and sustained attention. Typical simple visual reaction times in healthy adults are commonly reported in the ~200–350ms range, with wide individual and situational variability [needs verification: exact population reference ranges should not be surfaced to users as a "normal" comparison without a verified source].

## Test Protocol

1. Brief instructions: tap the screen as soon as a shape appears; do not tap before it appears.
2. Practice round (3 trials) with feedback on obvious false starts.
3. Main test: 10 trials with randomized inter-stimulus intervals (1.5–3.5s) to prevent rhythm anticipation; 2 of the 10 are catch trials with no stimulus (tapping during a catch trial is scored as a false start, excluded from the latency mean, and reduces confidence).
4. Each trial's latency is measured from stimulus-paint time to input-event time.

## Stimulus Design

A simple filled shape drawn via `CustomPaint`, sized using standard UI touch-target guidance rather than calibrated visual-angle geometry (this test measures timing, not spatial resolution, so it deliberately does not route through `OptotypeSizing`). Random inter-stimulus intervals use a seeded RNG for main-phase reproducibility in tests.

## Scoring Method

`meanReactionTimeMs` = mean latency across valid (non-catch, non-false-start) trials. `metrics['falseStarts']` = count of catch-trial or premature responses. `accuracy` = fraction of trials with a valid, non-false-start response.

## Confidence

- Reduced if false-start count is high (suggests anticipatory tapping rather than genuine reaction).
- Reduced if fewer than 6 valid trials were completed.

## Known Limitations

- Touch-input latency varies by device (touchscreen sampling rate, OS input pipeline), which this app cannot fully control for or calibrate out.
- Not a clinical reaction-time or attention-disorder assessment.
- **v1.0.0 implementation note:** catch trials (described in the Test Protocol above) are not yet implemented; all main-phase trials present a real stimulus. False-start detection (tapping before the stimulus appears) is still recorded and excluded from the mean. Catch trials are planned for a future protocol version and will bump `testVersion` when added.

## Potential Confounders

Device input latency, user fatigue, distraction, practice/learning effects across repeated sessions.

## User-Facing Interpretation

"Your average reaction time on this screening task was approximately X ms. Reaction time varies with device, alertness, fatigue, and practice, so this is not a clinical or diagnostic measurement and should not be compared across different devices."

## References

- Simple reaction time as a standard visual-motor/attention screening measure is well established in cognitive psychology; specific population reference ranges are not cited here pending verification and are intentionally not shown to users as a normative comparison. [needs verification]
