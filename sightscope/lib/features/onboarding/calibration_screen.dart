import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/calibration/calibration_confidence.dart';
import '../../core/calibration/calibration_math.dart';
import '../../core/calibration/calibration_provider.dart';
import '../../core/calibration/calibration_result.dart';
import '../../core/calibration/lighting_guidance.dart';
import '../../core/calibration/viewing_distance.dart';
import '../../core/theme/app_spacing.dart';

/// Credit-card screen calibration (Task.md §12.3): the user resizes an
/// on-screen rectangle to match a real ID-1 card held against the screen.
/// All resulting sizing math routes through [CalibrationMath] — this screen
/// never invents its own PPI formula.
class CalibrationScreen extends ConsumerStatefulWidget {
  const CalibrationScreen({super.key, this.onDone});

  /// Optional callback fired after calibration is saved (used by tests and
  /// by test-intro flows that need to gate on calibration before proceeding).
  final VoidCallback? onDone;

  @override
  ConsumerState<CalibrationScreen> createState() => _CalibrationScreenState();
}

class _CalibrationScreenState extends ConsumerState<CalibrationScreen> {
  double _widthLogicalPx = 260;

  @override
  Widget build(BuildContext context) {
    final double dpr = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      appBar: AppBar(title: const Text('Calibrate your screen')),
      body: SingleChildScrollView(
        padding: AppSpacing.padScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hold a standard credit card (or similar ID card) flat against your '
              'screen and adjust the slider until the outline below matches its width.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AppSpacing.gapLg,
            Center(
              child: Container(
                key: const Key('calibration_card_outline'),
                width: _widthLogicalPx,
                height: _widthLogicalPx * (CalibrationMath.creditCardShortEdgeMm / CalibrationMath.creditCardLongEdgeMm),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            AppSpacing.gapLg,
            Slider(
              value: _widthLogicalPx,
              min: 120,
              max: 500,
              onChanged: (v) => setState(() => _widthLogicalPx = v),
            ),
            AppSpacing.gapMd,
            Text(LightingGuidance.headline, style: Theme.of(context).textTheme.titleLarge),
            AppSpacing.gapSm,
            const Text(LightingGuidance.body),
            AppSpacing.gapMd,
            Text(ViewingDistance.standardHandheld.instructions),
            AppSpacing.gapLg,
            FilledButton(
              onPressed: () async {
                final double measuredEdgePx = _widthLogicalPx * dpr;
                final double ppi = CalibrationMath.ppiFromPhysicalEdge(
                  measuredEdgePx: measuredEdgePx,
                  physicalEdgeMm: CalibrationMath.creditCardLongEdgeMm,
                );
                final result = CalibrationResult(
                  ppi: ppi,
                  method: CalibrationMethod.creditCard,
                  calibratedAt: DateTime.now(),
                  viewingDistanceMm: ViewingDistance.standardHandheld.mm,
                );
                await ref.read(calibrationProvider.notifier).save(result);
                widget.onDone?.call();
                if (context.mounted) context.pop();
              },
              child: const Text('Confirm calibration'),
            ),
            AppSpacing.gapSm,
            OutlinedButton(
              onPressed: () async {
                final double ppi = CalibrationMath.ppiFromDiagonal(
                  widthPx: MediaQuery.of(context).size.width * dpr,
                  heightPx: MediaQuery.of(context).size.height * dpr,
                  diagonalInches: 6.1,
                );
                final result = CalibrationResult(
                  ppi: ppi,
                  method: CalibrationMethod.deviceDefault,
                  calibratedAt: DateTime.now(),
                  viewingDistanceMm: ViewingDistance.standardHandheld.mm,
                );
                await ref.read(calibrationProvider.notifier).save(result);
                widget.onDone?.call();
                if (context.mounted) context.pop();
              },
              child: const Text('Skip — use an approximate default'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small chip shown on test intro screens summarizing calibration state.
class CalibrationSummary extends StatelessWidget {
  const CalibrationSummary({super.key, required this.result});

  final CalibrationResult? result;

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return const Text('Not calibrated yet — results will be approximate.');
    }
    final CalibrationConfidence confidence = result!.confidence;
    return Text(
      'Calibrated (${result!.method.name}) — confidence: ${confidence.level.name}',
    );
  }
}
