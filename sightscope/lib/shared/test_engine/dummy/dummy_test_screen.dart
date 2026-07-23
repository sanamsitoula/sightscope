import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/database_provider.dart';
import '../../../core/theme/app_spacing.dart';
import '../../models/enums.dart';
import '../domain/test_result.dart';
import '../engine/test_device_context.dart';
import '../engine/test_result_repository.dart';
import '../engine/test_session_controller.dart';
import 'dummy_test_definition.dart';

/// Drives [DummyTestDefinition] through the full engine lifecycle
/// (Task.md §12.4): start → practice → main → score → persist → reload.
class DummyTestScreen extends ConsumerStatefulWidget {
  const DummyTestScreen({super.key});

  @override
  ConsumerState<DummyTestScreen> createState() => _DummyTestScreenState();
}

class _DummyTestScreenState extends ConsumerState<DummyTestScreen> {
  late final TestSessionController _controller;
  TestResult? _reloaded;
  String _log = '';

  @override
  void initState() {
    super.initState();
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    _controller = TestSessionController(
      definition: const DummyTestDefinition(),
      deviceContext: const TestDeviceContext(
        deviceModel: 'unknown',
        screenSize: 'unknown',
        screenDensity: 0,
        eyeTested: Eye.both,
        correctionUsed: CorrectionUsed.unknown,
      ),
      repository: repository,
    );
    _controller.start();
    _append('started');
  }

  void _append(String line) => setState(() => _log = '$_log\n$line');

  Future<void> _runFullFlow() async {
    _controller.acknowledgeInstructions();
    _controller.confirmCalibration();
    _controller.beginPractice();
    while (!_controller.isQueueExhausted) {
      _controller.recordResponse(answer: const {'choice': 0}, durationMillis: 200);
    }
    _controller.beginMainTest();
    while (!_controller.isQueueExhausted) {
      _controller.recordResponse(answer: const {'choice': 0}, durationMillis: 200);
    }
    final result = _controller.score();
    _controller.acknowledgeLimitations();
    _controller.chooseNextStep();
    _controller.complete();
    await _controller.persist();
    final repository = TestResultRepository(ref.read(appDatabaseProvider));
    final reloaded = await repository.loadById(result.sessionId!);
    setState(() => _reloaded = reloaded);
    _append('phase: ${_controller.state.phase}');
    _append('score: ${result.score}, accuracy: ${result.accuracy}');
    _append('reloaded: ${reloaded != null}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Engine demo')),
      body: Padding(
        padding: AppSpacing.padScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilledButton(onPressed: _runFullFlow, child: const Text('Run full flow')),
            AppSpacing.gapMd,
            Text('Phase: ${_controller.state.phase.name}'),
            if (_reloaded != null)
              Text('Reloaded result score: ${_reloaded!.score.toStringAsFixed(2)}'),
            AppSpacing.gapMd,
            Expanded(child: SingleChildScrollView(child: Text(_log))),
          ],
        ),
      ),
    );
  }
}
