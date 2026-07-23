import 'package:drift/drift.dart';

/// Phase-0 result schema (Task.md §12.5 / spec.md §19 field list).
///
/// This is the first schema version. Per Task.md §5, changing this schema
/// after Gate 0 requires explicit approval.
///
/// Row class is named [TestResultRow] (not the Drift default `TestResult`)
/// to avoid colliding with the domain [TestResult] model.
@DataClassName('TestResultRow')
class TestResults extends Table {
  /// Unique row id — the engine session id.
  TextColumn get id => text()();

  TextColumn get testId => text()();
  TextColumn get testVersion => text()();
  DateTimeColumn get date => dateTime()();

  TextColumn get deviceModel => text()();

  /// Human-readable, e.g. "1080x2400".
  TextColumn get screenSize => text()();

  /// True PPI used to size stimuli for this session.
  RealColumn get screenDensity => real()();

  RealColumn get brightnessIfAvailable => real().nullable()();

  /// Viewing distance in millimetres.
  RealColumn get viewingDistance => real().nullable()();

  /// [Eye] enum name.
  TextColumn get eyeTested => text()();

  /// [CorrectionUsed] enum name.
  TextColumn get correctionUsed => text()();

  /// JSON-encoded `List<TestResponse>`.
  TextColumn get rawResponsesJson => text()();

  RealColumn get score => real()();
  RealColumn get accuracy => real()();
  RealColumn get reactionTime => real()();

  /// JSON-encoded `TestScoring` (full metrics map, not just the scalars above).
  TextColumn get scoringJson => text()();

  /// JSON-encoded `TestConfidence`.
  TextColumn get confidenceJson => text()();

  TextColumn get environmentNotes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
