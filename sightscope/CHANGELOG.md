# Changelog

## v0.2.0-beta (Phase 2 — Perception lab)

Builds on the v0.1.0-alpha core screening MVP. Adds the six Phase-2 feature
groups per Task.md §16 / spec.md Phase 2, plus personal trends and separate
profile dimensions:

- **Depth Perception**: pictorial/motion depth-cue judgment task — explicitly
  documented as *not* a binocular stereoacuity test (a flat display cannot
  present binocular disparity).
- **Peripheral Awareness**: central-fixation peripheral-flash localization
  with catch trials to flag guessing.
- **Visual Attention**: color-odd-one-out visual search across increasing
  distractor counts.
- **Visual Memory**: change-detection working-memory screening with an
  approximate Cowan's K estimate.
- **Motion Perception**: adaptive-coherence random-dot-kinematogram
  direction discrimination, rendered as a pure function of animation time
  (no mutable per-frame dot state).
- **Eye Fatigue Questionnaire**: original 5-item self-report symptom survey
  (explicitly not a validated clinical instrument).
- **Trends**: deterministic baseline-vs-current comparison per test
  dimension, with confidence and neutral, non-alarmist language — never
  combined across dimensions.
- **Profile**: each test dimension's latest result shown independently;
  there is no combined "vision score" or "brain score" anywhere in the app.

The test-engine's adaptive-staircase support (added in Phase 1 for visual
acuity/near vision/contrast sensitivity) is now also used by motion
perception. An accessibility pass adds screen-reader semantics for
optotypes and a high-contrast comparability notice across test intro
screens; the motion-perception intro additionally flags reduced-motion
settings, since that test cannot be meaningfully redesigned as static.

### Known limitations
- Depth Perception cannot measure true binocular stereoacuity on a single
  flat display — see `research/stereo_depth.md`.
- Peripheral Awareness cannot verify the user maintained central fixation.
- The high-contrast accessibility notice is wired into the shared
  optotype-staircase flow and all Phase-2 test intros, but was not
  retrofitted onto every Phase-1 screen.
- Visual Memory's Cowan's K estimate is based on very few trials per set
  size and is explicitly labeled approximate.

## v0.1.0-alpha (Phase 1 — Core screening MVP)

Builds on the v0.0.1-foundation engine/calibration/theme layer. Adds the
first seven user-facing feature groups per Task.md §14 / spec.md Phase 1:

- **Onboarding**: first-launch, non-diagnostic disclaimer gate (blocks the
  rest of the app until accepted); credit-card screen calibration flow with
  a device-default fallback.
- **Home dashboard**: entry points to every test, history, education, and
  calibration.
- **Visual acuity**: adaptive logMAR staircase alternating Tumbling E and
  Landolt C optotypes, drawn via `CustomPaint`, sized exclusively through
  the Phase-0 calibration/optotype-sizing utilities.
- **Near vision & reading**: the same acuity engine at a fixed ~40cm
  reading distance.
- **Contrast sensitivity**: adaptive contrast staircase at a fixed,
  above-threshold optotype size.
- **Color perception**: original, procedurally generated pseudoisochromatic-
  style dot plates (no bundled/copyrighted assets) screening for red-green
  color differences.
- **Reaction time**: simple visual reaction-time trials with randomized
  inter-stimulus intervals and false-start detection (catch trials deferred
  to a later protocol version — see `research/reaction_time.md`).
- **Local history**: on-device list of all persisted results (Drift-backed,
  no network calls).
- **Eye-and-brain education**: static, source-grounded informational
  content on the visual pathway and why screening results vary.

Every test runs through the shared Phase-0 engine (`TestSessionController`
+ `TestDefinition`), which now also supports adaptive (staircase-driven)
stimulus generation in addition to the fixed-queue mode used by simpler
tests. Every result screen carries the required non-diagnostic advisory.

### Known limitations
- Reaction-time catch trials are not yet implemented (see research doc).
- Calibration is either credit-card-measured or an approximate device
  default; no OS-level physical-diagonal lookup (no such dependency is in
  the locked stack).
- Golden tests were generated and verified on this development machine;
  cross-platform font/rendering differences may require regenerating them
  on the CI reference platform before they can gate CI.
- Android App Bundle / iOS archive: see build notes below.

## v0.0.1-foundation (Phase 0 — Foundation)

Material 3 theme, credit-card screen calibration + true-PPI math,
visual-angle/optotype-sizing geometry, the shared test-engine domain model
and session controller, Drift-backed result persistence, and an
engine-demonstration dummy test.
