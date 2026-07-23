/// Phases every SightScope test session moves through (Task.md §11).
///
/// The order is advisory; the controller enforces the legal transitions.
enum TestSessionPhase {
  notStarted,
  introduction,
  instructions,
  calibrationCheck,
  practice,
  mainTest,
  scoring,
  confidence,
  result,
  limitations,
  nextStep,
  completed,
  cancelled,
}
