# SightScope — Design System & Brand Guide (v2 "Quiet Precision")

This is the technical design-system reference for SightScope: every color,
font, spacing value, shape, motion curve, graphic, and component actually
implemented in the app, with the exact file each one lives in. It
complements (doesn't replace) the marketing copy in the project-root
`brand.md` — that file has the tagline, store copy, and voice; this file has
the visual system that copy is delivered in.

**v2 direction — "Quiet Precision":** restraint over decoration. Ink/sage/
stone palette instead of a rainbow of per-test colors, flat surfaces instead
of gradients and shadows, hairline borders instead of elevation, and large
confident typography for results. Core principle: *lightweight in
performance, heavy in perception* — the app should feel like a carefully
designed scientific instrument, not a generic medical utility.

**Golden rule behind every visual decision in this app:** nothing is a
bundled image, video, or font file. Every graphic — the logo, the eye
illustrations, the optotypes, the color-vision plates, the moving dots — is
drawn at runtime with Flutter's `CustomPaint`/`Canvas` API.

---

## 1. Brand identity

| | |
|---|---|
| Name | **SightScope** |
| Tagline | *"See how you see."* |
| Supporting statement | *"Vision, measured with clarity."* |
| Positioning | A private personal vision laboratory for understanding how you see. |
| Personality | Scientific, premium, clinical-but-warm, human, modern, trustworthy — never overclaims. |
| Full copy | See project-root `brand.md` for store listings and long-form descriptions. |

---

## 2. Logo & app icon

**File:** `lib/shared/widgets/app_icon_painter.dart` (`AppIconPainter`)
**Generator:** `test/tool/generate_app_icons.dart` — rasterizes the painter at
every required Android/iOS size and writes the PNGs directly into
`android/app/src/main/res/mipmap-*/ic_launcher.png` and
`ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-*.png`.

**Concept:** the eye as an aperture — vision + precision + observation, not
a cartoon eye. Flat fills only: no gradients, no glow, no violet.

| Layer | Color | Spec |
|---|---|---|
| Background | Ink `#101820` | Flat square (iOS masks its own corners); `0.22×s` corner radius on Android |
| Outer eye | Canvas `#F7F8F6` | Minimal almond curve, strong negative space |
| Iris | Sage `#6F9188` | Perfect circle, `r = 0.155×s` |
| Pupil | Ink `#101820` | Circle, `r = 0.065×s` |
| Highlight | Gold `#B39A63` | One small circle, `r = 0.028×s` — the icon's only accent color |

Rerun the generator whenever the design changes:
```bash
flutter test test/tool/generate_app_icons.dart
```

**In-app brand mark** (distinct from the app icon — used on hero headers,
not launchers): `EyeGraphic` / `EyeIconPainter` in
`lib/shared/widgets/eye_icon_painter.dart`. An almond-shaped eye with a flat
sage iris (no gradient), dark pupil, and highlight — drawn in white on the
Deep Ink hero background.

**Focus Target** (`lib/shared/widgets/focus_target_painter.dart`): the
brand's second graphic mark — concentric rings + cardinal tick marks, like a
scope reticle. Used for Reaction Time's stimulus and reserved for future
attention-related screens.

---

## 3. Color system

**File:** `lib/core/theme/app_colors.dart` — a restrained ink/sage/stone
system, not a rainbow of per-test colors. Gold is reserved for rare,
deliberate highlight moments (the app icon's highlight dot) — it must never
become a general UI color.

| Token | Hex | Role |
|---|---|---|
| `ink` | `#101820` | Primary text, dark surfaces, primary visual weight |
| `deepInk` | `#071014` | Hero headers, premium/dark moments |
| `canvas` | `#F7F8F6` | (available — app icon background reference) |
| `surface` | `#FFFFFF` | Cards, elevated content, test surfaces |
| `sage` | `#6F9188` | Primary brand accent — icons, focus indicators, brand marks |
| `deepSage` | `#42665F` | Primary button background, strong interactive/selected states |
| `softSage` | `#E8EFEC` | Subtle containers, selected backgrounds |
| `warmStone` | `#E9E6DF` | Calibration and other neutral supporting surfaces |
| `gold` | `#B39A63` | Extremely sparing — icon highlight only. Never a general UI color |
| `border` | `#E3E7E4` | The single hairline border color used everywhere |
| `success` | `#3F806C` | Correct-answer feedback |
| `caution` | `#A77B43` | Advisory/callout tone (muted, not saturated) |
| `error` | `#A45D5D` | Incorrect-answer feedback |
| `info` | `#66838C` | Reserved informational tone |
| `stimulusInk` / `stimulusPaper` | = `ink` / `surface` | Optotype rendering — intentionally brand-neutral (§10) |

The app's `ColorScheme` (`lib/core/theme/app_theme.dart`) maps these
explicitly rather than deriving from a single seed — the brand system
specifies exact hex values per role, so `ColorScheme.light()`/`.dark()` are
built with named colors, not `ColorScheme.fromSeed`.

### Color usage rule

Tests are told apart by **name, icon shape, and content — not color.** The
v1 system gave each of the 11 tests its own accent color; v2 removes that.
Every test icon on the dashboard renders in the same single tone (`ink`),
uniform size, no colored circle badge. This is a deliberate premium/cohesion
choice (docs/brand.md v2 §4 in the design brief).

---

## 4. Typography

**File:** `lib/core/theme/app_typography.dart` — platform default font, no
bundled font file.

| Style | Size | Weight | Tracking | Used for |
|---|---|---|---|---|
| `display` | 36 | 600 | −1.0 | Reserved for major brand/splash moments |
| `hero` | 30 | 600 | −0.5 | Dashboard hero, major screen titles |
| `sectionTitle` | 20 | 600 | — | Section headers, compact hero titles |
| `cardTitle` | 16 | 600 | — | Card titles, button label text |
| `body` | 15 | 400 | — | Primary instructional copy |
| `secondary` | 13 | 400 | — | Secondary copy, limitations text |
| `overline` | 10 | 600 | +1.8 | Small uppercase editorial labels — apply `.toUpperCase()` to the string yourself. Used for "YOUR RESULT", "WHAT THIS TESTS", "CONFIDENCE", "PRACTICE", dashboard section labels |
| `metric` | 48 | 600 | −1.5, tabular | Test result values — the visually dominant number on every result screen |

---

## 5. Spacing system

**File:** `lib/core/theme/app_spacing.dart` — 4pt base grid.

| Token | Value |
|---|---|
| `xs` / `sm` / `md` | 4 / 8 / 16px |
| `lg` | 24px — **default screen padding** (`padScreen`) |
| `xl` | 32px |
| `xxl` | 48px |
| `xxxl` | 64px (reserved) |

| Padding preset | Value | Used for |
|---|---|---|
| `padScreen` | 24h / 24v | Default screen padding |
| `padHero` | 24h / 40v | Hero header padding |
| `padResult` | 32h / 48v | Major result screens |

---

## 6. Shape system

**File:** `lib/core/theme/app_shapes.dart`

| Token | Radius | Used for |
|---|---|---|
| `radiusSmall` | 8px | Small utility surfaces |
| `radiusMedium` | 14px | Standard controls |
| `radiusLarge` | 20px | Cards, content containers (dashboard rows, purpose cards, how-to carousel) |
| `radiusXl` | 28px | Hero containers, major result surfaces |
| `pill` | stadium | Primary/outlined buttons only |

Soft but not playful — no fully circular cards, no exaggerated rounding.

---

## 7. Elevation & borders

**Elevation stays at 0 everywhere.** Hierarchy comes from spacing,
background tone, borders, and typography — not shadows. Every card
(`CardThemeData` in `app_theme.dart`) is a flat surface with a 1px `border`
hairline instead of a shadow. This is enforced at the theme level, so it
applies automatically to every `Card` in the app.

---

## 8. Motion

**File:** `lib/core/theme/app_motion.dart`

| Token | Duration | Curve |
|---|---|---|
| `micro` | 120ms | — |
| `standard` | 240ms | `easeOutCubic` |
| `screen` | 320ms | `easeInOutCubic` |
| `result` | 450ms | `easeOutCubic` |

Motion explains, it never decorates: the how-to carousel (teaching a
procedure), the RDK stimulus (the actual test content), and the reaction-time
focus-target pulse (cueing the response) are the only animations in the app.

---

## 9. Component library

| Component | File | What it is |
|---|---|---|
| `GradientHeroHeader` | `lib/shared/widgets/gradient_hero_header.dart` | Flat Deep Ink hero banner (name kept for call-site compatibility — no gradient in v2). Used on onboarding, the dashboard, calibration, and every test intro. |
| `EyeGraphic` / `EyeIconPainter` | `lib/shared/widgets/eye_icon_painter.dart` | The almond-eye brand flourish on hero headers. |
| `AppIconPainter` | `lib/shared/widgets/app_icon_painter.dart` | The launcher-icon mark (§2). |
| `FocusTargetPainter` / `FocusTarget` | `lib/shared/widgets/focus_target_painter.dart` | Scope-reticle mark — Reaction Time's stimulus. |
| `TestPurposeCard` | `lib/shared/widgets/test_purpose_card.dart` | "WHAT THIS TESTS / WHY IT HELPS" overline-labeled card. Copy centrally registered in `kTestPurposeInfo`. |
| `HowToCarousel` | `lib/shared/widgets/how_to_carousel.dart` | Auto-advancing 3-step "how to take this test" sequence — the dependency-free substitute for a demo video (see `docs/animated_howto_prompt.md`). |
| `AccessibilityNotice` | `lib/shared/test_engine/widgets/accessibility_notice.dart` | High-contrast comparability warning on test intros. |
| `OptotypePainter` / `OptotypeView` | `lib/shared/test_engine/widgets/optotype_painter.dart` | Tumbling E / Landolt C stimulus — brand-neutral by design (§10 below). |
| `ColorPlatePainter` | `lib/features/color_vision/color_plate_painter.dart` | Procedural pseudoisochromatic-style dot plates. |
| `RdkPainter` | `lib/features/motion_perception/rdk_painter.dart` | Random-dot-kinematogram motion stimulus. |
| `TrendBarChart` | `lib/features/trends/trend_bar_chart.dart` | Baseline-vs-current comparison, `border`/`sage` bars. |

### Buttons

Set globally in `app_theme.dart` — every `FilledButton`/`OutlinedButton` in
the app picks these up automatically:

| Property | Value |
|---|---|
| Height | 56px minimum |
| Radius | Pill (stadium) |
| Background (Filled) | `deepSage` |
| Text | `cardTitle` style, white on Filled |
| Elevation | 0 |

Labels are standardized: **"Start test"**, **"Continue"**, **"Confirm
calibration"**, **"Save and finish"** — never a bare "Start".

> **Implementation note:** button minimum size must be `Size(64, 56)`, not
> `Size.fromHeight(56)` — the latter sets minimum *width* to infinity, which
> crashes any button placed inside a `Row` without `Expanded` (this was
> caught and fixed via the visual-memory and motion-perception screens'
> Same/Changed and Left/Right button rows).

### Cards

One flat pattern everywhere: `surface` background, `radiusLarge` (20px),
1px `border` hairline, no shadow. Dashboard rows add a leading `ink`-tone
icon (no colored badge) and a trailing arrow.

---

## 10. Screen anatomy

### Home dashboard (`lib/features/home/home_dashboard_screen.dart`)
A personal instrument panel, not a grid of colorful app tiles. Pinned
`SliverAppBar` (148px, Deep Ink) with the flat hero header and five icon
actions (Trends, Profile, History, Learn, Calibrate). Below: a **"LAST
SESSION"** card (shows the most recent result's date, or an empty-state
prompt to start with Visual Acuity) sourced live from `historyProvider`,
then two sections — **"CORE SCREENING"** and **"PERCEPTION LAB"** — each an
overline label followed by bordered, single-tone-icon rows.

### Onboarding (`lib/features/onboarding/disclaimer_screen.dart`)
Full hero header, **"Before you begin"**, three icon+title+body points (no
colored circle badges — a plain `sage` icon and text), a `softSage` advisory
callout, and a full-width CTA.

### Calibration (`lib/features/onboarding/calibration_screen.dart`)
Compact hero header (no eye badge), a `warmStone` instruction card, a flat
`softSage`-filled card-outline matcher with a `deepSage` border (no
gradient), icon-led lighting/distance info rows, and two stacked CTAs.

### Test intro screens (all tests)
`GradientHeroHeader` (compact) → `TestPurposeCard` → (acuity-family +
reaction time) `HowToCarousel` → `AccessibilityNotice` (conditional) →
full-width "Start test" CTA.

### Result screens
The most important premium screens in the app. Consistent hierarchy:
**"YOUR RESULT"** overline → the `metric`-styled score → test name →
divider → **"CONFIDENCE"** overline → level → divider → **"WHAT THIS
MEANS"** overline → limitations text → the non-diagnostic advisory →
full-width "Continue". Implemented fully in the shared
`StaircaseOptotypeFlowScreen._ResultView` (visual acuity, near vision,
contrast sensitivity) and reaction time; the remaining Phase-2 result
screens share the same token set but not yet the full metric/overline
layout (see §12).

### Test stimulus screens
The brand deliberately disappears during measurement — flat `stimulusPaper`
background, `stimulusInk` optotypes, a plain bordered card, no color, no
shadow. This is unchanged from v1 and remains a core principle: "the test
should feel precise, neutral, and scientifically controlled."

---

## 11. EyeGuard (eye wellness)

**Files:** `lib/features/eye_wellness/` — `domain/eye_exercise_engine.dart`
(the "One-Minute Reset" guided exercise), `domain/reminder_engine.dart`
(deterministic, unit-tested threshold rules — no AI, matching ai.md's
"deterministic first" principle), `domain/screen_session_tracker.dart`
(continuous in-app foreground timer), `domain/app_usage_analyzer.dart`
(deterministic summary over raw usage entries), `data/eye_wellness_settings*.dart`
(persisted preferences, same secure-storage pattern as calibration),
`data/notification_service.dart` (`flutter_local_notifications` wrapper),
`data/app_usage_datasource.dart` (`usage_stats` wrapper, Android-only),
`presentation/*` (dashboard, settings, and the exercise player, reusing the
Deep Ink + overline + metric result language from §10).

**Dependencies added:** `flutter_local_notifications`, `permission_handler`,
`usage_stats` — approved explicitly by the user before adding (Task.md's
dependency stop-condition). Android manifest additions:
`POST_NOTIFICATIONS` (Android 13+, requested at runtime via
`permission_handler` only when the user turns Notifications on) and
`PACKAGE_USAGE_STATS` (a "special access" permission with **no runtime
dialog** — the user must grant it from Settings; the app links there
directly when App Usage Insights is turned on). `android/app/build.gradle.kts`
also needed `isCoreLibraryDesugaringEnabled = true` +
`coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:...")`, which
`flutter_local_notifications` requires.

**What's genuinely implemented now:**
- Deterministic reminders (blink/relaxation, sensitivity-adjustable) shown
  in-app, and optionally as a system notification if the user opts in.
- The guided One-Minute Reset exercise.
- **Android-only** "today's screen time" insights via `usage_stats`
  (`UsageStatsManager`) — top apps by foreground time, only after the user
  explicitly grants "Usage access" in system Settings. Off by default.
- All of the above stay on-device; nothing is uploaded anywhere.

**Still a hard platform limit, not a missing dependency:** iOS has **no
public API** for third-party apps to read system-wide app usage — Apple
restricts that to parental-control apps under a Family Controls
entitlement it grants selectively. `AppUsageDataSource.isSupported` is
`false` on iOS and every call site checks `Platform.isAndroid` before
showing usage-insight UI; the settings screen states this directly rather
than showing a broken/empty feature. Camera-based blink detection remains
explicitly future/Phase-5 and AI-gated (ai.md AI-04) — not implemented.

**Windows build note:** `usage_stats`'s Android Gradle module isn't
migrated to Flutter's "Built-in Kotlin" yet (a build-time warning, not a
failure) and its Kotlin compilation can hit a Windows-only incremental-cache
bug (`Storage for [...] is already registered`). Fixed here via
`kotlin.incremental=false` in `android/gradle.properties` — if this
package is ever swapped out, that workaround can likely be removed.

## 12. Known gaps / next design opportunities

- The full `metric`/overline result layout is implemented on the shared
  acuity-family flow and reaction time; color vision, peripheral vision,
  visual attention, visual memory, motion perception, depth perception, and
  eye fatigue use the v2 color/type tokens but still lay out their result
  screens as a simple label list rather than the full YOUR RESULT →
  CONFIDENCE → WHAT THIS MEANS structure.
- `display` (36px) and `xxxl` (64px spacing) are defined but unused —
  headroom for a future splash/marketing screen.
- No dedicated animated splash screen exists yet (the OS-default launch
  background is used); the design brief's splash sequence (dark background →
  outer eye → iris → pupil → wordmark, 0–900ms) is not yet implemented.
- `AccessibilityNotice` covers the acuity-family flow, color vision, and
  every Phase-2 test; reaction time doesn't show it yet.
