## Objective
Build VisionMind, the Flutter vision-screening and visual-perception app fully specified in ./SPEC.md, phase by phase with verification and release gates. SPEC.md is the authoritative product requirements document — read it completely before writing any code, and follow its scientific-language rules, privacy rules, and architecture exactly.

## Context
- Greenfield Flutter project (stable channel, Dart 3, Material 3), created via `flutter create visionmind`.
- ./SPEC.md in the project root contains the full 30-section product spec: test modules, test engine abstraction, architecture tree (SPEC.md §25), design direction, accessibility, privacy, research documentation requirements, and MVP phase ordering (§28).
- Stack locked per SPEC.md §1: Riverpod, GoRouter, Freezed + json_serializable, Drift (choose Drift over raw SQLite), flutter_secure_storage for preferences. Offline-first, no login, no network calls in Phases 0–2.

## Phase Plan — execute strictly in order, one phase per instruction from me
Do NOT start a phase until I explicitly say "Start Phase N". After finishing a phase, run its Verification Gate, output the gate report, and STOP.

### PHASE 0 — Foundation (no user-facing tests yet)
Build: project scaffold matching SPEC.md §25 architecture tree; design system (theme, typography, colors per §23); calibration module (credit-card screen calibration → true PPI, viewing-distance instructions, lighting guidance per §20); the reusable test engine (TestDefinition, TestSession, TestStimulus, TestResponse, TestScoring, TestResult, TestConfidence, TestHistory per §5); Drift schema for results with all fields from §19; /research directory template per §27.
Verification Gate 0:
- [ ] flutter analyze → 0 errors, 0 warnings
- [ ] Unit tests pass: PPI math, mm→px conversion, optotype sizing formula, test-engine session lifecycle, scoring determinism
- [ ] A demo "dummy test" runs end-to-end through the engine and persists a result
- [ ] Git: commit + tag v0.0.1-foundation

### PHASE 1 — Core screening MVP (SPEC.md §28 Phase 1)
Build in order: onboarding (§3), home dashboard (§4), visual acuity (§6, tumbling-E + Landolt C via CustomPaint, adaptive staircase, per-eye flow), near vision & reading (§7), contrast sensitivity (§8), color perception (§9, ORIGINAL procedurally generated plates — never copyrighted Ishihara assets), reaction time (§12), local history (§19), eye-and-brain educational visualization (§17).
Each test MUST use the Phase 0 engine and include intro, instructions, calibration check, practice round, main test, result + confidence + limitations + next step, per §5. Every result screen carries the non-diagnostic advisory per §2.
For each test, write its /research/<test>.md doc (purpose, protocol, scoring, limitations, references) BEFORE implementing it. Cite only real, verifiable sources; if uncertain about a reference, mark it [needs verification] rather than inventing one.
Verification Gate 1:
- [ ] All 7 Phase-1 features complete end-to-end and persist scored results
- [ ] Acuity sizing verified by unit test against 5-arcminute optotype geometry at calibrated distance
- [ ] Widget tests for every test screen; integration test for one full acuity session including interruption + resume
- [ ] Golden tests for dashboard and one optotype render
- [ ] Disclaimer gate on first launch; no forbidden diagnostic language anywhere (grep the codebase for "diagnos", "you have", "prescription" and review hits)
- [ ] flutter analyze clean; all tests pass
- [ ] Release: bump to v0.1.0, build Android appbundle + iOS archive instructions, write CHANGELOG.md, tag v0.1.0-alpha (internal testing track)

### PHASE 2 — Perception lab (SPEC.md §28 Phase 2)
Build: stereo/depth (§10), peripheral awareness (§11), visual attention (§13), visual memory (§14), motion perception (§15), eye-fatigue questionnaire (§16), personal trends + profile dimensions (§18, separate dimensions — never one combined score).
Verification Gate 2:
- [ ] All Phase-2 tests run through the same engine with research docs written first
- [ ] Trend charts show baseline vs current with confidence, no alarmist framing
- [ ] Accessibility pass per §24: screen reader labels, reduced motion, high-contrast warning that comparability may break
- [ ] Full test suite green; integration test covering a multi-test session
- [ ] Release: v0.2.0-beta, CHANGELOG updated, tag, closed-beta build notes

### PHASE 3 — Extended platform (SPEC.md §28 Phase 3)
Camera-based features, research/export mode with explicit consent, cloud sync (Supabase, opt-in, encrypted), multi-language. Each sub-feature gets its own plan + my approval BEFORE implementation. AI screening features require the validation checklist in SPEC.md §22 and must not ship without my explicit sign-off.
Verification Gate 3: defined per sub-feature at planning time; release v1.0.0 only after I approve.

## Scope
- Work only in: the visionmind project root.
- Do NOT touch: signing configs, .env, CI secrets. Do NOT modify SPEC.md except to append clarification notes I approve.

## Constraints
- Dependencies beyond the locked stack: ask first.
- All charts/optotypes/plates/grids drawn via CustomPaint — zero bundled copyrighted test assets.
- All physical sizing through the single calibration utility — never hardcoded pixels for stimuli.
- Scientific scoring must be deterministic and unit-testable.
- Only build what the current phase specifies. Do not pull Phase 2/3 work forward.

## Stop Conditions
Stop and ask before: adding any dependency; deleting any file; changing the Drift schema after Gate 0; deviating from SPEC.md; anything requiring network access; starting the next phase.

## Progress
After each completed step: ✅ [what was done] — [file(s) affected]. At each gate: full gate report with pass/fail per checkbox.

Think carefully and step-by-step before starting: begin by reading SPEC.md in full, then output your Phase 0 implementation plan for my approval before writing code.

## Session Strategy
New session. Run /compact between phases, focused on: architecture decisions, engine API, and gate results.