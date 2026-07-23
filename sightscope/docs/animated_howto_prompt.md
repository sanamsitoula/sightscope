# Prompt: Generating a "How to Take the Visual Acuity Test" Animation

SightScope currently ships an in-app animated illustration (see
`HowToCarousel` in `lib/shared/widgets/how_to_carousel.dart`) instead of a
bundled video/GIF file, to keep the app dependency-free and avoid shipping
binary media assets. If you want a polished, real animated explainer (for
the app store listing, onboarding, or marketing), use a prompt like the
one below with an AI video/image-generation tool (e.g. Runway, Pika,
Sora, Kling, or an illustrator + After Effects/Lottie pipeline).

## Prompt (video/GIF generator)

```
A clean, friendly 8-second looping explainer animation for a mobile vision-
screening app called SightScope, in a minimal flat-illustration style with
a calm teal (#0E7C86) and soft violet (#7A5AF8) color palette on a white
background. Three sequential beats, each ~2.5 seconds, with smooth
crossfade transitions:

1. A simplified side-view illustration of a person's arm holding a
   smartphone at a comfortable arm's-length distance from their face —
   a subtle dashed measuring line between the phone and the eye, with a
   small ruler icon, communicating "hold at the right distance."

2. The same person illustration with one hand gently covering one eye —
   a small icon of an eye with a line through it appears near the covered
   eye — communicating "test one eye at a time."

3. A close-up of the phone screen showing a simple ring shape with a gap
   on one side (a Landolt-C-style optotype) and a fingertip tapping an
   arrow button that points toward the gap — communicating "tap the arrow
   that matches the gap or opening."

Style: soft rounded shapes, no photorealism, no text overlays (captions
will be added separately), gentle ease-in-out motion, no harsh flashes,
1:1 or 9:16 aspect ratio suitable for a mobile app onboarding screen.
```

## Notes for whoever generates this

- Keep it non-diagnostic and instructional only — no claims about results,
  scores, or health outcomes anywhere in the animation.
- If captions are added, reuse the exact step copy already in
  `_kOptotypeHowTo` (`lib/shared/test_engine/screens/staircase_optotype_flow_screen.dart`)
  and `_kReactionHowTo` (`lib/features/reaction_time/reaction_time_screen.dart`)
  so in-app and marketing copy stay consistent.
- Once a real asset exists, wiring it in requires adding a video-playback
  dependency (e.g. `video_player`) or an animation-format dependency (e.g.
  `lottie`) — per Task.md's dependency-approval rule, that needs explicit
  sign-off before it's added to `pubspec.yaml`, since it's outside the
  currently locked stack.
