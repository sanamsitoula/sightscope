# Eye Fatigue Questionnaire

## Purpose

Capture a brief, structured self-report of digital eye-strain-related symptoms, as a subjective complement to the app's performance-based tests.

## What This Test Measures

Self-reported frequency of common digital-eye-strain symptoms (eye strain, dryness, blurred vision after screen use, headaches, difficulty focusing) on a 5-point frequency scale, summarized as a mean symptom score.

## Scientific Background

Digital eye strain / computer vision syndrome symptom questionnaires are a standard, non-invasive way to capture subjective visual discomfort associated with screen use [needs verification: exact validated instrument/citation, e.g. CVS-Q]. SightScope's questionnaire is an original, short-form set of plain-language items inspired by this general category of self-report instrument — it is explicitly not a validated clinical questionnaire and is presented as a self-report screening tool only.

## Test Protocol

1. Instructions: answer honestly based on the last few days/typical recent screen use; there are no right or wrong answers.
2. No practice phase (self-report items don't have a "correct" practice trial).
3. Main test: a fixed set of 5 Likert-style items, each rated 0 ("never") to 4 ("very often").

## Stimulus Design

Each item is a plain-text question with a 5-point button/slider response — no calibrated visual stimuli are involved, so this test intentionally does not route through `OptotypeSizing`/`VisualAngle`.

## Scoring Method

`score` = mean item rating (0–4). `metrics['itemScores']` records each item's individual rating for transparency.

## Confidence

Fixed at medium: self-report data is inherently subjective and this is a screening instrument, not a validated clinical questionnaire — confidence bucketing based on "convergence" doesn't apply here.

## Known Limitations

- Not a validated clinical instrument (e.g. not the CVS-Q or OSDI); it is an original, short, plain-language self-report tool.
- Purely subjective; not cross-checked against any objective measurement in this version.
- Recall bias: answers depend on how accurately the user recalls recent symptoms.

## Potential Confounders

Mood, general fatigue unrelated to screen use, recent illness (e.g. allergies affecting eye dryness), how the questions are interpreted.

## User-Facing Interpretation

"Your responses suggest [low/moderate/frequent] self-reported digital eye-strain symptoms recently. This is a self-report screening questionnaire, not a diagnosis of digital eye strain, dry eye disease, or any other condition. If symptoms are frequent or bothersome, consider discussing them with a qualified eye-care professional."

## References

- Digital eye strain / computer vision syndrome symptom questionnaires are a recognized category of self-report instrument in vision-science and occupational-health literature. Exact validated instrument and citation: [needs verification].
