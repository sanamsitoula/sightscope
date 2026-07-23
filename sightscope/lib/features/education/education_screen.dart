import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class _Topic {
  const _Topic(this.title, this.body);
  final String title;
  final String body;
}

/// Eye-and-brain educational content (Task.md §14 / spec.md §17). Static,
/// non-interactive information — no personalized claims, no scores.
const List<_Topic> _kTopics = [
  _Topic(
    'The retina',
    'Light entering your eye is focused onto the retina, a light-sensitive layer at the back '
        'of the eye. Photoreceptor cells there — rods and cones — convert light into electrical '
        'signals. Cones, concentrated in the central retina, handle color and fine detail; rods, '
        'more numerous toward the periphery, handle low-light and peripheral vision.',
  ),
  _Topic(
    'The optic nerve and visual pathway',
    'Signals from the retina travel along the optic nerve toward the brain. Information from '
        'both eyes is combined and routed through relay stations before reaching the visual '
        'cortex at the back of the brain, where the earliest stages of "seeing" — as opposed to '
        'simply sensing light — begin.',
  ),
  _Topic(
    'Sensation vs. perception',
    'Your eyes sense light; your brain constructs perception. The brain fills gaps, stabilizes '
        'a moving world, and interprets ambiguous signals using prior experience and attention. '
        'This is why two people can look at the same scene and notice different things.',
  ),
  _Topic(
    'Why vision tests can vary session to session',
    'Screening tests like the ones in this app depend on many factors beyond your eyes alone: '
        'attention, fatigue, lighting, screen brightness, and viewing distance all influence '
        'results. A single result is a snapshot, not a fixed measurement of your visual system.',
  ),
];

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('How your eyes and brain see')),
      body: ListView.separated(
        padding: AppSpacing.padScreen,
        itemCount: _kTopics.length,
        separatorBuilder: (context, i) => AppSpacing.gapMd,
        itemBuilder: (context, i) {
          final topic = _kTopics[i];
          return Card(
            child: Padding(
              padding: AppSpacing.padScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.title, style: Theme.of(context).textTheme.titleLarge),
                  AppSpacing.gapSm,
                  Text(topic.body),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
