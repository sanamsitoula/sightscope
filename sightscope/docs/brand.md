# SightScope — Design System & Brand Guide

This is the technical design-system reference for SightScope: every color, font,
spacing value, shape, motion curve, graphic, and component actually implemented
in the app, with the exact file each one lives in. It complements (doesn't
replace) the marketing copy in the project-root `brand.md` — that file has the
tagline, store copy, and voice; this file has the visual system that copy is
delivered in.

**Golden rule behind every visual decision in this app:** nothing is a bundled
image, video, or font file. Every graphic — the logo, the eye illustrations,
the optotypes, the color-vision plates, the moving dots — is drawn at runtime
with Flutter's `CustomPaint`/`Canvas` API. This keeps the app dependency-free,
tiny, infinitely scalable, and consistent with the project's "no copyrighted
or bundled test assets" rule for scientific stimuli — extended here to
branding too.

---

## 1. Brand identity

| | |
|---|---|
| Name | **SightScope** |
| Tagline | *"See how you see. Vision, measured."* |
| Short tagline | *"See how you see."* |
| Positioning | A personal vision lab in your pocket — science-inspired screening tests, explained honestly, tracked privately. |
| Tone | Calm, clinical-but-warm, never alarmist, always transparent about limitations. |
| Full copy | See project-root `brand.md` for store listings, onboarding copy, and long-form descriptions. |

---

## 2. Logo & app icon

**File:** `lib/shared/widgets/app_icon_painter.dart` (`AppIconPainter`)
**Generator:** `test/tool/generate_app_icons.dart` — rasterizes the painter at
every required Android/iOS size and writes the PNGs directly into
`android/app/src/main/res/mipmap-*/ic_launcher.png` and
`ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-*.png`.

**Construction** (all values relative to the icon's shortest side `s`):

| Layer | Spec |
|---|---|
| Background | Linear gradient, top-left → bottom-right, `#11929E → #7A5AF8`, corner radius `0.22×s` on Android (flat square on iOS — the OS masks its own corners) |
| Ambient glow | White circle, `r = 0.40×s`, 10% opacity, centered |
| Sclera (eye body) | White filled circle, `r = 0.32×s` |
| Iris | Dark navy `#0B1220` filled circle, `r = 0.165×s`, with a `0.02×s`-thick teal (`#11929E`) ring stroke |
| Highlight | White circle, `r = 0.045×s`, offset `(-0.07×s, -0.07×s)` from center |

Rerun the generator whenever the design changes:
```bash
flutter test test/tool/generate_app_icons.dart
```

**In-app brand mark** (distinct from the app icon — used on headers, not
launchers): `EyeGraphic` / `EyeIconPainter` in
`lib/shared/widgets/eye_icon_painter.dart`. An almond-shaped eye (bezier
outline) with a radial-gradient iris, dark pupil, and highlight dot. On
`GradientHeroHeader` it's drawn in solid white inside a translucent white
circle badge (14% white on the gradient) — a simplified, badge-friendly
variant of the same eye motif as the app icon, keeping the two visually
related without being identical.

---

## 3. Color system

**File:** `lib/core/theme/app_colors.dart`

| Token | Hex | Role |
|---|---|---|
| `brandSeed` | `#0E7C86` | Primary brand teal. Seeds the entire Material 3 `ColorScheme` via `ColorScheme.fromSeed`. Used directly for icons, headers, primary CTAs. |
| `accent` | `#7A5AF8` | Secondary violet accent — perception/attention-themed screens, the reaction-time target, memory test badge. |
| `stimulusInk` | `#111418` | Near-black used for optotypes (Tumbling E / Landolt C) — never pure `#000` to stay slightly softer under high contrast. |
| `stimulusPaper` | `#FAFBFC` | Near-white background for optotype cards — same reasoning, avoids pure white glare. |
| `okGreen` | `#1F9D55` | Correct-answer feedback icon (acuity/near-vision/contrast trial feedback). |
| `warnAmber` | `#B7791F` | Incorrect-answer feedback icon; also the disclaimer screen's "see a professional" callout. |

The rest of the palette (surfaces, containers, outlines, `onSurface`, etc.) is
**derived automatically** by Material 3 from `brandSeed` via
`ColorScheme.fromSeed(seedColor: AppColors.brandSeed, brightness: ...)` in
`lib/core/theme/app_theme.dart` — light and dark variants both come from this
one seed, so the whole app's tonal palette stays harmonized without hand-picked
grays.

**Per-test accent colors** (dashboard icon badges only — not part of the core
token set, defined locally in `lib/features/home/home_dashboard_screen.dart`):

| Test | Color |
|---|---|
| Visual Acuity | `#0E7C86` (brand teal) |
| Near Vision & Reading | `#3F6FBF` |
| Contrast Sensitivity | `#6B4EA6` |
| Color Perception | `#E0632E` |
| Reaction Time | `#EFB93C` |
| Depth Perception | `#35C2C1` |
| Peripheral Awareness | `#4C9F70` |
| Visual Attention | `#C2559C` |
| Visual Memory | `#7A5AF8` (accent) |
| Motion Perception | `#3F8FBF` |
| Eye Fatigue Questionnaire | `#B7791F` (warnAmber) |

Each color tints a `CircleAvatar` icon badge at 15% opacity background with the
full color as the icon tint — a consistent "colored badge + icon" pattern used
everywhere a test is listed (dashboard, and implicitly via `TestPurposeCard`'s
brand-teal badge on intro screens).

---

## 4. Typography

**File:** `lib/core/theme/app_typography.dart`
Platform default font (no bundled font file — Material 3's system font stack),
so there's zero font-loading cost and it always matches OS text-rendering
conventions.

| Style | Size | Weight | Line height | Used for |
|---|---|---|---|---|
| `displayLarge` | 32 | 700 | 1.15 | Reserved for largest display moments (not yet used on any current screen — headroom for a future splash/marketing screen) |
| `headlineLarge` | 26 | 700 | 1.2 | Hero header titles (`GradientHeroHeader`, non-compact) |
| `headlineMedium` | 22 | 600 | 1.25 | Compact hero header titles; result-screen "Your result" headings |
| `titleLarge` | 19 | 600 | 1.3 | Section headers, card titles, calibration instructions headline |
| `bodyLarge` | 16 | 400 | 1.45 | Primary instructional/body copy |
| `bodyMedium` | 14 | 400 | 1.45 | Secondary copy, card subtitles, limitations text |
| `labelLarge` | 14 | 600 | +0.2 letter-spacing | Button labels, "Practice" tag, purpose-card labels |
| `labelSmall` | 11 | 600 | +0.5 letter-spacing | Reserved for the smallest UI chrome (not yet used) |
| `metricValue` | 30 | 700 | tabular figures | Test result scores — tabular figures keep digits from jittering in width as they update |

`titleLarge` is frequently down-sized inline (`?.copyWith(fontSize: 15–16)`)
for card titles that need `titleLarge`'s weight but a smaller footprint —
search for `.copyWith(fontSize:` in the feature screens to find these local
overrides.

---

## 5. Spacing system

**File:** `lib/core/theme/app_spacing.dart` — 4pt base grid.

| Token | Value | Typical use |
|---|---|---|
| `xs` | 4px | Tight icon/text gaps |
| `sm` | 8px | Card-internal gaps, list separators |
| `md` | 16px | Standard gap between grouped elements; `padScreen` horizontal/vertical inset |
| `lg` | 24px | Section-to-section gaps, pre-CTA spacing |
| `xl` | 32px | Hero header vertical padding (non-compact) |
| `xxl` | 48px | Reserved for largest layout breathing room (not yet used) |

`AppSpacing.padScreen` = `EdgeInsets.symmetric(horizontal: md, vertical: md)`
— the single screen-edge padding constant used on every scrollable body.

---

## 6. Shape system

**File:** `lib/core/theme/app_shapes.dart`

| Token | Radius | Used for |
|---|---|---|
| `radiusXs` | 4px | (available, not currently used standalone) |
| `radiusSm` | 8px | Calibration card outline corners |
| `radiusMd` | 12px | (available) |
| `radiusLg` | 16px | `TestPurposeCard`, `HowToCarousel` containers, dashboard test cards |
| `radiusXl` | 24px | `GradientHeroHeader` bottom corners, optotype display card, app-icon corner rounding (Android) |
| `stadium` | pill | All `FilledButton`s (via `AppTheme.filledButtonTheme`) |

Icon badges, the reaction-time target, avatars, and the app icon's
sclera/iris/pupil are all perfect circles (`BoxShape.circle`) — the app's
consistent "circle = interactive/brand element, rounded rect = container"
shape language.

---

## 7. Motion

**File:** `lib/core/theme/app_motion.dart`

| Token | Duration | Curve | Used for |
|---|---|---|---|
| `instant` | 80ms | — | (available for micro-feedback) |
| `quick` | 150ms | — | (available) |
| `standard` | 250ms | `easeOut` (`standardCurve`) | `HowToCarousel` step fade+scale transition |
| `slow` | 400ms | — | (available) |
| `emphasized` | — | `easeInOutCubicEmphasized` | Reserved for future large-scale transitions |
| `incoming` | — | `easeOutCubic` | Reserved for entrance animations |

**Named animated moments in the app today:**
- `HowToCarousel` — auto-advances every 2s (`Timer.periodic`), each step
  fades + scales in via `AnimatedSwitcher` (`AppMotion.standard`), with a
  pill/dot progress indicator that widens (6px → 18px) for the active step.
- Reaction-time target (`_GlowingTarget` in `reaction_time_screen.dart`) —
  a `700ms` reverse-repeating pulse, scaling `1.00 → 1.08`, via a raw
  `AnimationController` (not yet wired to the `AppMotion` tokens — a good
  future cleanup).
- Motion-perception RDK (`RdkPainter`) — dot motion is a **pure function of
  animation time** (`AnimationController` value 0→1 over 1.5s, non-repeating),
  not manual per-frame state — deliberately deterministic and side-effect-free.
- `AccessibilityNotice` respects `Accessibility.reduceMotion(context)`
  (`lib/core/accessibility/accessibility.dart`) as the single source of truth
  for whether to shorten/skip decorative motion — currently consulted by the
  motion-perception intro to show a reduced-motion notice; not yet wired
  into every animated widget above (see §11).

---

## 8. Component library

| Component | File | What it is |
|---|---|---|
| `GradientHeroHeader` | `lib/shared/widgets/gradient_hero_header.dart` | The banner used on onboarding, the dashboard, calibration, acuity-family tests, and reaction time. Brand-gradient background, bottom-rounded corners, title/subtitle, optional white eye badge. Has a `compact` mode (smaller padding/type scale) for non-hero screens. |
| `EyeGraphic` / `EyeIconPainter` | `lib/shared/widgets/eye_icon_painter.dart` | The almond-eye brand flourish drawn inside `GradientHeroHeader`. |
| `AppIconPainter` | `lib/shared/widgets/app_icon_painter.dart` | The launcher-icon mark (see §2). |
| `TestPurposeCard` | `lib/shared/widgets/test_purpose_card.dart` | "What this tests / Why it helps" card. Content is centrally registered in `kTestPurposeInfo` (one entry per `testId`) so copy never drifts screen-to-screen. |
| `HowToCarousel` | `lib/shared/widgets/how_to_carousel.dart` | Auto-advancing 3-step "how to take this test" illustrated sequence — the in-app, dependency-free substitute for a demo video (see `docs/animated_howto_prompt.md` for a prompt to generate a real video/GIF externally). |
| `AccessibilityNotice` | `lib/shared/test_engine/widgets/accessibility_notice.dart` | High-contrast comparability warning, shown conditionally on test intros. |
| `OptotypePainter` / `OptotypeView` | `lib/shared/test_engine/widgets/optotype_painter.dart` | Tumbling E / Landolt C stimulus rendering — the only place optotype geometry is drawn, always fed calibrated px sizes, never invents its own. |
| `ColorPlatePainter` | `lib/features/color_vision/color_plate_painter.dart` | Procedural pseudoisochromatic-style dot plates (420 dots/plate, seeded for reproducibility). |
| `RdkPainter` | `lib/features/motion_perception/rdk_painter.dart` | Random-dot-kinematogram motion stimulus. |
| `OrientationResponsePad` | `lib/shared/test_engine/widgets/orientation_response_pad.dart` | The 4-direction arrow response control shared by acuity/near-vision/contrast/peripheral-vision. |
| `TrendBarChart` | `lib/features/trends/trend_bar_chart.dart` | Minimal two-bar baseline-vs-current comparison chart. |

### Buttons

| Style | Where | Shape |
|---|---|---|
| `FilledButton` | Every primary CTA ("Start", "Continue", "Confirm calibration", "I understand, continue") | Stadium (pill), `padding: h24/v14` via `AppTheme.filledButtonTheme` |
| `FilledButton.tonal` | Color-vision shape choices | Stadium, tonal (lower-emphasis) fill |
| `FilledButton.icon` | Motion-perception left/right response | Stadium, leading icon |
| `OutlinedButton` | Calibration's "skip" path, eye-fatigue rating options | Default Material 3 outlined shape |
| `IconButton.filledTonal` | `OrientationResponsePad` arrows | Circular, tonal fill |
| Plain `IconButton` | App-bar actions (trends/profile/history/learn/calibrate) | Circular, no fill (icon-only) |

Primary CTAs are consistently wrapped `SizedBox(width: double.infinity, child: FilledButton(...))` — full-width buttons anchored to the bottom of scrollable content, never floating/inline, so the "next action" is always the same shape and position across every screen.

### Cards

Two card patterns, both derived from the same `CardThemeData` in
`app_theme.dart` (`surfaceContainer` fill, 0 elevation, 0 margin — spacing is
controlled explicitly by each screen, not by the card):

1. **Static info card** — a plain `Card`/`Container` with `radiusLg` and a
   `CircleAvatar` icon leading a title/body column (onboarding points,
   `TestPurposeCard`, education topics).
2. **Interactive list card** — `Material` + `InkWell` (dashboard test cards)
   so the ripple feedback is themed correctly, with a `CircleAvatar` icon
   badge, title/subtitle column, and trailing chevron.

---

## 9. Screen anatomy

### "Landing page" — Home dashboard (`lib/features/home/home_dashboard_screen.dart`)
This is the app's true landing page (reached after the one-time onboarding
gate). `CustomScrollView` + pinned `SliverAppBar` (168px expanded height,
brand-teal background) with `GradientHeroHeader` as the flexible space —
title *"SightScope"*, subtitle *"Your personal vision lab — test, measure,
track."* — and five white icon actions (Trends, Profile, History, Learn,
Calibrate). Below the fold: two labeled sections, **"Core screening"** and
**"Perception lab"**, each a `_SectionHeader` (icon + title + one-line
subtitle) followed by stacked colored test cards.

### Onboarding (`lib/features/onboarding/disclaimer_screen.dart`)
Full (non-compact) `GradientHeroHeader` with the brand tagline, then
**"Before you begin"**, three icon+title+body point cards (science-based
screening, results-affected-by-conditions, private-by-default), an amber
"see a professional if concerned" callout, and a full-width CTA. This is the
one screen every user sees exactly once (gated by `SecurePrefs`/
`disclaimer_accepted`).

### Calibration (`lib/features/onboarding/calibration_screen.dart`)
Compact `GradientHeroHeader` (no eye badge — this screen already has a
physical-card visual), an icon+instruction card, the interactive card-outline
matcher (gradient-tinted rounded rect with a centered credit-card icon,
resized by a slider), then icon-led lighting/distance info rows, and two
stacked full-width CTAs (confirm / skip-to-default).

### Test intro screens (all tests)
Every test intro now follows the same anatomy: `GradientHeroHeader` (compact)
→ `TestPurposeCard` → (acuity-family + reaction time only) `HowToCarousel` →
`AccessibilityNotice` (conditional) → full-width "Start" CTA.

### Reaction time (`lib/features/reaction_time/reaction_time_screen.dart`)
The one screen with a fully custom in-trial background: a top-to-bottom
gradient (`colorScheme.surface → surfaceContainerHighest`) instead of the flat
scaffold background, so the pulsing gradient/glow target (`#B18CFF → accent`,
`36px` blur / `6px` spread glow) reads clearly against a slightly different
tone than the rest of the app.

---

## 10. UX/UI principles

1. **Every result screen ends the same way**: score → confidence → the
   required non-diagnostic advisory → a clearly separated "Continue" action.
   No result screen skips the advisory, and its wording is deliberately
   templated (see the `TestResult`-consuming widgets) so it can't drift
   toward stronger claims over time.
2. **Feedback is color *and* icon**, never color alone —
   `Icons.check_circle`/`Icons.cancel` in `okGreen`/`warnAmber`, so trial
   feedback doesn't rely on color perception (notably important given one of
   the tests screens for color-vision differences).
3. **One CTA shape everywhere**: full-width stadium `FilledButton` for the
   "next step" action. Users never have to relearn what the primary button
   looks like between screens.
4. **Consistent colored-badge iconography**: every test has exactly one
   color (§3) and one `Icons.*` glyph, reused identically on the dashboard
   card, and implicitly via the teal badge on `TestPurposeCard`.
5. **Motion is explanatory, not decorative**: the only animations in the app
   are the how-to carousel (teaching a procedure), the RDK stimulus (the
   actual test content), and the reaction-time pulse (drawing attention to
   the response target) — nothing animates purely for flourish.
6. **Backgrounds stay flat except where gradient adds meaning**: the brand
   gradient appears only on hero headers and the app icon; everything else
   uses the Material 3 surface tokens straight from the seeded color scheme,
   so gradients stay a deliberate "this is a brand moment" signal rather than
   wallpaper.

---

## 11. Known gaps / next design opportunities

- Reaction-time pulse animation and a few inline durations aren't wired to
  the `AppMotion` tokens yet — worth centralizing.
- `AccessibilityNotice` covers the acuity-family flow (visual acuity, near
  vision, contrast sensitivity all share it), color vision, and every
  Phase-2 test — the one screen still missing it is reaction time.
- `displayLarge` and `labelSmall` type styles and the `xxl` spacing token are
  defined but unused — reserved for a future full-bleed splash/marketing
  moment.
- No dedicated splash screen exists yet (the OS-default launch background is
  used); `AppIconPainter`'s gradient would be a natural basis for one.
