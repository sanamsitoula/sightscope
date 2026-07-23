# Depth Perception (Pictorial & Motion Cues)

## Purpose

Screen sensitivity to depth cues available on a single flat, 2D display, and clearly separate this from true binocular stereoacuity.

## What This Test Measures

The user's ability to judge relative depth ordering of shapes using monocular ("pictorial") depth cues — relative size, occlusion/interposition, and motion parallax — presented on-screen.

## Scientific Background

True stereoscopic depth perception (stereopsis) arises from binocular disparity: each eye receives a slightly different horizontal-offset image of the same scene, and the visual system computes depth from that offset. A single flat phone or tablet screen presents the *same* image to both eyes, so it **cannot** measure binocular disparity thresholds the way a clinical stereo test (e.g. a polarized/red-cyan stereogram or a physical stereoscope) can [needs verification: comparison framing should be reviewed against current clinical stereo-test literature]. What a flat screen *can* present are monocular ("pictorial") depth cues — relative size, occlusion, linear perspective, and motion parallax — which the visual system also uses to infer depth, and which remain informative even with one eye closed.

Given this hardware constraint, SightScope's "Depth Perception" screening test is explicitly a pictorial/motion-cue task, not a stereoacuity test, and is labeled as such everywhere it appears in the UI.

## Test Protocol

1. Instructions clarify this is not a binocular stereo test.
2. Practice round with an easy, unambiguous depth-cue trial.
3. Main test: a fixed sequence of trials, each showing two overlapping/offset shapes rendered with a combination of relative-size, occlusion, and (for a subset of trials) a brief parallax animation as the "camera" shifts slightly; the user taps whichever shape appears nearer.
4. Trials vary the strength of the depth cue (large vs. subtle size/occlusion difference) in a fixed, non-adaptive sequence.

## Stimulus Design

Shapes are drawn with `CustomPaint`. Relative size and occlusion amount are the manipulated variables (not physical/visual-angle calibrated, since this test is about depth-order judgment, not acuity) — this is a deliberate, documented exception to routing every stimulus through `OptotypeSizing`, because this test measures a *relative* ordinal judgment, not a calibrated physical size threshold.

## Scoring Method

`accuracy` = fraction of trials where the user correctly identified the nearer shape given the ground-truth depth ordering used to generate the stimulus.

## Confidence

Medium by default (this is a screening task on a flat display, not a clinical stereo test); explicitly reduced/annotated to note it does not measure binocular stereoacuity at all.

## Known Limitations

- Does not measure true stereoacuity (binocular disparity threshold) — a flat single display cannot do this without additional hardware (glasses, lenticular/parallax-barrier display, etc.).
- Motion-parallax trials require the device to render a brief camera-shift animation, which may be affected by reduced-motion accessibility settings (see Accessibility notes).
- Not validated against any clinical stereo test (e.g. Titmus, Randot).

## Potential Confounders

Screen brightness/contrast, prior familiarity with depth-cue illusions, attention/fatigue.

## User-Facing Interpretation

"This screening task measures your ability to judge depth from on-screen visual cues like relative size and overlap — not true binocular stereo depth, which this device's screen cannot measure directly. This is an educational self-assessment, not a diagnosis of any stereo-vision or depth-perception condition."

## References

- General depth-cue taxonomy (pictorial cues vs. binocular disparity) is standard in vision-science texts; exact primary sources: [needs verification].
