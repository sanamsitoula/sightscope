import '../engine/test_result_repository.dart';
import 'test_result.dart';

/// Read-side helper over persisted results for a given test (Task.md §11).
class TestHistory {
  const TestHistory(this._repository);

  final TestResultRepository _repository;

  Future<List<TestResult>> forTest(String testId) => _repository.loadByTestId(testId);

  Future<List<TestResult>> all() => _repository.loadAll();

  Future<TestResult?> latestFor(String testId) async {
    final List<TestResult> results = await forTest(testId);
    return results.isEmpty ? null : results.first;
  }
}
