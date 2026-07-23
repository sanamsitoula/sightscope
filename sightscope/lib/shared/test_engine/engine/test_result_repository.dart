import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/storage/database.dart';
import '../../models/enums.dart';
import '../domain/test_confidence.dart';
import '../domain/test_response.dart';
import '../domain/test_result.dart';
import '../domain/test_scoring.dart';

/// Persists and reloads [TestResult]s through [AppDatabase] (Drift only —
/// never raw SQLite, per Task.md §12.5).
class TestResultRepository {
  TestResultRepository(this._db);

  final AppDatabase _db;

  Future<void> save(TestResult result) async {
    final String id = result.sessionId ?? '${result.testId}-${result.date.microsecondsSinceEpoch}';
    await _db.into(_db.testResults).insertOnConflictUpdate(
          TestResultsCompanion.insert(
            id: id,
            testId: result.testId,
            testVersion: result.testVersion,
            date: result.date,
            deviceModel: result.deviceModel,
            screenSize: result.screenSize,
            screenDensity: result.screenDensity,
            brightnessIfAvailable: Value(result.brightnessIfAvailable),
            viewingDistance: Value(result.viewingDistance),
            eyeTested: result.eyeTested.name,
            correctionUsed: result.correctionUsed.name,
            rawResponsesJson: jsonEncode(
              result.rawResponses.map((TestResponse r) => r.toJson()).toList(),
            ),
            score: result.score,
            accuracy: result.accuracy,
            reactionTime: result.reactionTime,
            scoringJson: jsonEncode(result.scoring.toJson()),
            confidenceJson: jsonEncode(result.confidence.toJson()),
            environmentNotes: Value(result.environmentNotes),
          ),
        );
  }

  Future<TestResult?> loadById(String id) async {
    final row = await (_db.select(_db.testResults)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  Future<List<TestResult>> loadByTestId(String testId) async {
    final rows = await (_db.select(_db.testResults)
          ..where((t) => t.testId.equals(testId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
    return rows.map<TestResult>(_fromRow).toList();
  }

  Future<List<TestResult>> loadAll() async {
    final rows =
        await (_db.select(_db.testResults)..orderBy([(t) => OrderingTerm.desc(t.date)])).get();
    return rows.map<TestResult>(_fromRow).toList();
  }

  TestResult _fromRow(TestResultRow row) {
    final List<dynamic> rawList = jsonDecode(row.rawResponsesJson) as List<dynamic>;
    return TestResult(
      testId: row.testId,
      testVersion: row.testVersion,
      date: row.date,
      deviceModel: row.deviceModel,
      screenSize: row.screenSize,
      screenDensity: row.screenDensity,
      brightnessIfAvailable: row.brightnessIfAvailable,
      viewingDistance: row.viewingDistance,
      eyeTested: Eye.values.byName(row.eyeTested),
      correctionUsed: CorrectionUsed.values.byName(row.correctionUsed),
      rawResponses: rawList
          .map((dynamic e) => TestResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      scoring: TestScoring.fromJson(jsonDecode(row.scoringJson) as Map<String, dynamic>),
      confidence:
          TestConfidence.fromJson(jsonDecode(row.confidenceJson) as Map<String, dynamic>),
      environmentNotes: row.environmentNotes,
      sessionId: row.id,
    );
  }
}
