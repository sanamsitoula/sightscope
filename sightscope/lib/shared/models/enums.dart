/// Marker interface for enums that expose a human-readable [label].
abstract interface class EnumLike {
  String get label;
}

/// Which eye was tested (or both).
enum Eye implements EnumLike {
  left,
  right,
  both;

  @override
  String get label => switch (this) {
        Eye.left => 'Left eye',
        Eye.right => 'Right eye',
        Eye.both => 'Both eyes',
      };
}

/// Optical correction worn during the test.
enum CorrectionUsed implements EnumLike {
  none,
  glasses,
  contacts,
  unknown;

  @override
  String get label => switch (this) {
        CorrectionUsed.none => 'No correction',
        CorrectionUsed.glasses => 'Glasses',
        CorrectionUsed.contacts => 'Contacts',
        CorrectionUsed.unknown => 'Not specified',
      };
}

/// Coarse, non-alarmist confidence bucket. Always paired with reasons in
/// [TestConfidence]; never used as a clinical guarantee.
enum ConfidenceLevel { low, medium, high }
