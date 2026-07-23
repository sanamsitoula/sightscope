import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'data_collection_list.dart';

/// Standing, read-only reference for "what does SightScope collect" —
/// reachable any time from the dashboard, reusing the exact same content
/// shown during first-launch consent so the two can never drift apart.
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Data')),
      body: SingleChildScrollView(
        padding: AppSpacing.padScreen,
        child: const DataCollectionList(),
      ),
    );
  }
}
