import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/test_results_table.dart';

part 'database.g.dart';

/// The single authoritative local database (Task.md §12.5).
///
/// Never use raw SQLite APIs directly — everything routes through here.
@DriftDatabase(tables: [TestResults])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// In-memory database for tests — never touches disk.
  AppDatabase.forTesting() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final Directory dir = await getApplicationDocumentsDirectory();
      final File file = File('${dir.path}${Platform.pathSeparator}sightscope.sqlite');
      return NativeDatabase.createInBackground(file);
    });
  }
}
