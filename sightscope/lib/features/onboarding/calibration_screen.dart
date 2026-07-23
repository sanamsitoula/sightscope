import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/calibration/calibration_confidence.dart';
import '../../core/calibration/calibration_math.dart';
import '../../core/calibration/calibration_provider.dart';
import '../../core/calibration/calibration_result.dart';
import '../../core/calibration/lighting_guidance.dart';
import '../../core/calibration/viewing_distance.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/gradient_hero_header.dart';

/// Credit-card screen calibration (Task.md §12.3): the user resizes an
/// on-screen rectangle to match a real ID-1 card held against the screen.
/// All resulting sizing math routes through [CalibrationMath] — this screen
/// never invents its own PPI formula.
///
/// This works the same way on every phone, tablet, or screen size: the
/// slider changes the *on-screen* size of the outline, and the app derives
/// this specific screen's true pixel density from wherever that outline
/// ends up matching the card — it never assumes a fixed screen size.
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientHeroHeader(
              title: 'Calibrate your screen',
              subtitle: 'Works the same on any phone or tablet — takes about 30 seconds.',
              compact: true,
              showEye: false,
            ),
            Padding(
              padding: AppSpacing.padScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.gapSm,
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warmStone,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.credit_card, color: AppColors.deepSage),
                        AppSpacing.gapSm,
                        Expanded(
                          child: Text(
                            'Hold a standard credit card (or similar ID card) flat against '
                            'your screen and drag the slider until the outline below exactly '
                            'matches its edges. It works no matter how big or small your '
                            'screen is — you\'re only matching the card, not a fixed size.',
                            style: AppTypography.body,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.gapLg,
                  Center(
                    child: _CardOutline(
                      widthLogicalPx: _widthLogicalPx,
                      aspectRatio:
                          CalibrationMath.creditCardShortEdgeMm / CalibrationMath.creditCardLongEdgeMm,
                    ),
                  ),
                  AppSpacing.gapLg,
                  Row(
                    children: [
                      const Icon(Icons.remove, size: 18),
                      Expanded(
                        child: Slider(
                          value: _widthLogicalPx,
                          min: 120,
                          max: 500,
                          onChanged: (v) => setState(() => _widthLogicalPx = v),
                        ),
                      ),
                      const Icon(Icons.add, size: 18),
                    ],
                  ),
                  AppSpacing.gapMd,
                  const _InfoRow(icon: Icons.wb_sunny_outlined, title: LightingGuidance.headline, body: LightingGuidance.body),
                  AppSpacing.gapSm,
                  _InfoRow(
                    icon: Icons.social_distance_outlined,
                    title: 'Viewing distance',
                    body: ViewingDistance.standardHandheld.instructions,
                  ),
                  AppSpacing.gapLg,
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
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
                  ),
                  AppSpacing.gapSm,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
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
                  ),
                  AppSpacing.gapMd,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardOutline extends StatelessWidget {
  const _CardOutline({required this.widthLogicalPx, required this.aspectRatio});

  final double widthLogicalPx;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final double height = widthLogicalPx * aspectRatio;
    return Container(
      key: const Key('calibration_card_outline'),
      width: widthLogicalPx,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.softSage,
        border: Border.all(color: AppColors.deepSage, width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Icon(
          Icons.credit_card,
          size: (height * 0.5).clamp(16, 40),
          color: AppColors.deepSage.withValues(alpha: 0.55),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.sage, size: 20),
        AppSpacing.gapSm,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.cardTitle),
              Text(body, style: AppTypography.secondary),
            ],
          ),
        ),
      ],
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
