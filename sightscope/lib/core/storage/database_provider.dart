import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';

/// The single app-wide [AppDatabase] instance.
final Provider<AppDatabase> appDatabaseProvider = Provider<AppDatabase>((ref) {
  final AppDatabase db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
