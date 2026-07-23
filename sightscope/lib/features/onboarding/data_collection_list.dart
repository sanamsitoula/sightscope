import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class _DataItem {
  const _DataItem(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}

/// What SightScope actually stores, kept in sync with the real
/// implementation — never a generic legal-boilerplate list. Update this
/// whenever a feature starts persisting a new category of data.
const List<_DataItem> _kCollected = [
  _DataItem(
    Icons.insights_outlined,
    'Vision test results',
    'Scores, your responses, and timestamps for each screening test you complete.',
  ),
  _DataItem(
    Icons.straighten,
    'Screen calibration',
    'Your screen\'s pixel density and viewing distance, used to size test stimuli accurately.',
  ),
  _DataItem(
    Icons.self_improvement_outlined,
    'Eye wellness activity',
    'How long SightScope has been open in the current session, and your reminder/exercise preferences.',
  ),
  _DataItem(
    Icons.tune,
    'App preferences',
    'Settings you choose, such as reminder sensitivity and whether you\'ve acknowledged onboarding.',
  ),
];

const List<_DataItem> _kNotCollected = [
  _DataItem(Icons.videocam_off_outlined, 'No camera or microphone access', ''),
  _DataItem(Icons.location_off_outlined, 'No location', ''),
  _DataItem(Icons.person_off_outlined, 'No account, email, or sign-in', ''),
  _DataItem(Icons.cloud_off_outlined, 'No network calls, analytics, ads, or cloud sync', ''),
];

/// The full "what data does SightScope collect" disclosure — shown both as
/// a first-launch consent step and as a standing reference in Settings, so
/// the two never drift out of sync.
class DataCollectionList extends StatelessWidget {
  const DataCollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('STORED ON THIS DEVICE', style: AppTypography.overline.copyWith(color: AppColors.sage)),
        AppSpacing.gapMd,
        for (final item in _kCollected) _Row(item: item, allowed: true),
        AppSpacing.gapLg,
        Text('NEVER COLLECTED', style: AppTypography.overline.copyWith(color: AppColors.ink.withValues(alpha: 0.55))),
        AppSpacing.gapMd,
        for (final item in _kNotCollected) _Row(item: item, allowed: false),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.item, required this.allowed});

  final _DataItem item;
  final bool allowed;

  @override
  Widget build(BuildContext context) {
    final Color tone = allowed ? AppColors.sage : AppColors.ink.withValues(alpha: 0.4);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 20, color: tone),
          AppSpacing.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: AppTypography.cardTitle),
                if (item.body.isNotEmpty) Text(item.body, style: AppTypography.secondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
