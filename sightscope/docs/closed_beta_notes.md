# Closed Beta Notes — v0.2.0-beta

## What's in this build

Phase 0 foundation + Phase 1 core screening MVP (visual acuity, near
vision, contrast sensitivity, color perception, reaction time, history,
education) + Phase 2 perception lab (depth perception, peripheral
awareness, visual attention, visual memory, motion perception, eye-fatigue
questionnaire, trends, profile). See `CHANGELOG.md` for full detail.

## What testers should know

- **Offline-first, no login, no network calls.** Everything stays on-device
  (Drift for results, `flutter_secure_storage` for calibration/disclaimer
  state).
- **Not a medical device.** Every result screen carries a non-diagnostic
  advisory. Please flag any wording that reads as a diagnosis or
  prescription — that's a bug, not a feature.
- **Calibrate first** for the most consistent results: Home → the ruler
  icon → hold a credit card to the screen and match the outline. Skipping
  this uses an approximate default and is clearly labeled as such.
- **Motion Perception** involves continuously moving dots. If motion
  sensitivity is a concern for you, feel free to skip that test — it's
  flagged on its intro screen, and reduced-motion accessibility settings
  are detected and noted (though the animation itself can't be replaced
  with something static and still measure motion perception).
- **Depth Perception** is explicitly *not* a true stereo/3D test — phone
  screens can't present separate images to each eye without extra
  hardware. It screens simpler on-screen depth cues (size, overlap) only.
- **Trends and Profile** never combine your results into one overall
  "vision score." Each test dimension (acuity, contrast, memory, etc.) is
  always shown and tracked separately.

## Known issues / things not to file as new bugs

- Reaction Time doesn't yet have "catch trials" (a stimulus that never
  appears, to detect anticipatory tapping) — planned for a later version.
- Peripheral Awareness can't verify you kept looking at the center dot.
- Golden (pixel-diff) tests were generated on the developer's machine and
  may need regenerating on whatever CI reference platform is adopted.

## How to report feedback

File issues with: device model, OS version, what you were doing, and
whether it's a crash, a visual glitch, confusing copy, or a factual/
scientific concern about a test's framing.
