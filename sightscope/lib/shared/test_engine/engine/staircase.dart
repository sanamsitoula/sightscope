/// Configuration for a 2-down/1-up adaptive staircase (Task.md/research
/// visual_acuity.md, near_vision.md, contrast_sensitivity.md).
///
/// Two consecutive correct responses step the level toward harder
/// (`stepTowardHarder`); a single incorrect response steps it toward
/// easier. This is a standard, deterministic, unit-testable adaptive
/// procedure — no randomness in the step logic itself.
class StaircaseConfig {
  const StaircaseConfig({
    required this.startLevel,
    required this.stepSize,
    required this.minLevel,
    required this.maxLevel,
    this.reversalsToTerminate = 4,
    this.maxTrials = 14,
    this.reversalsUsedForThreshold = 4,

    /// If true, "harder" means decreasing the level (e.g. logMAR, contrast).
    /// If false, "harder" means increasing it.
    this.harderIsLower = true,
  });

  final double startLevel;
  final double stepSize;
  final double minLevel;
  final double maxLevel;
  final int reversalsToTerminate;
  final int maxTrials;
  final int reversalsUsedForThreshold;
  final bool harderIsLower;
}

/// Deterministic 2-down/1-up adaptive staircase engine.
class Staircase {
  Staircase(this.config) : level = config.startLevel;

  final StaircaseConfig config;

  double level;
  int _correctStreak = 0;
  int? _lastDirection; // -1 == moved harder, +1 == moved easier
  int trialCount = 0;
  final List<double> reversalLevels = <double>[];

  bool get isDone =>
      reversalLevels.length >= config.reversalsToTerminate || trialCount >= config.maxTrials;

  /// Feed one trial outcome. Must not be called after [isDone].
  void recordResponse(bool correct) {
    trialCount++;
    if (correct) {
      _correctStreak++;
      if (_correctStreak >= 2) {
        _step(harder: true);
        _correctStreak = 0;
      }
    } else {
      _step(harder: false);
      _correctStreak = 0;
    }
  }

  void _step({required bool harder}) {
    final int direction = harder ? -1 : 1;
    if (_lastDirection != null && _lastDirection != direction) {
      reversalLevels.add(level);
    }
    _lastDirection = direction;

    final double signedStep = config.harderIsLower
        ? (harder ? -config.stepSize : config.stepSize)
        : (harder ? config.stepSize : -config.stepSize);
    level = (level + signedStep).clamp(config.minLevel, config.maxLevel);
  }

  /// Threshold estimate: mean of the last N reversal levels, or the current
  /// level if the staircase never reversed (e.g. cut short).
  double get threshold {
    if (reversalLevels.isEmpty) return level;
    final int n = config.reversalsUsedForThreshold.clamp(1, reversalLevels.length);
    final List<double> tail = reversalLevels.sublist(reversalLevels.length - n);
    return tail.reduce((a, b) => a + b) / tail.length;
  }
}
