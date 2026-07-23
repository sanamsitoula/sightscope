/// Guided eye-relaxation exercise engine. A fixed sequence of steps drives
/// the exercise player — new exercises can be added without rewriting the
/// UI, matching the shared test-engine's "definition + player" pattern.
enum EyeExerciseStepType {
  lookAway,
  blink,
  lookLeft,
  lookRight,
  lookUp,
  lookDown,
  closeEyes,
  breathe,
}

class EyeExerciseStep {
  const EyeExerciseStep({
    required this.type,
    required this.duration,
    required this.title,
    required this.instruction,
  });

  final EyeExerciseStepType type;
  final Duration duration;
  final String title;
  final String instruction;
}

/// The "One-Minute Reset" exercise (docs/brand.md-adjacent EyeGuard spec).
/// Never forces uncomfortable eye movement — every step is gentle and the
/// whole exercise is optional and skippable.
const List<EyeExerciseStep> kOneMinuteReset = [
  EyeExerciseStep(
    type: EyeExerciseStepType.lookAway,
    duration: Duration(seconds: 10),
    title: 'Look away',
    instruction: 'Find something farther away and focus on it.',
  ),
  EyeExerciseStep(
    type: EyeExerciseStepType.blink,
    duration: Duration(seconds: 10),
    title: 'Blink slowly',
    instruction: 'Blink gently a few times. Relax your eyelids.',
  ),
  EyeExerciseStep(
    type: EyeExerciseStepType.lookLeft,
    duration: Duration(seconds: 8),
    title: 'Look left, then center',
    instruction: 'Look gently to the left, then return to center.',
  ),
  EyeExerciseStep(
    type: EyeExerciseStepType.lookRight,
    duration: Duration(seconds: 7),
    title: 'Look right, then center',
    instruction: 'Look gently to the right, then return to center.',
  ),
  EyeExerciseStep(
    type: EyeExerciseStepType.lookUp,
    duration: Duration(seconds: 8),
    title: 'Look up, then center',
    instruction: 'Look upward, then return to center.',
  ),
  EyeExerciseStep(
    type: EyeExerciseStepType.lookDown,
    duration: Duration(seconds: 7),
    title: 'Look down, then center',
    instruction: 'Look downward, then return to center.',
  ),
  EyeExerciseStep(
    type: EyeExerciseStepType.closeEyes,
    duration: Duration(seconds: 10),
    title: 'Close your eyes',
    instruction: 'Close your eyes gently and take a slow breath.',
  ),
];
