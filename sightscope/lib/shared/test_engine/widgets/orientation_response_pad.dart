import 'package:flutter/material.dart';

/// Four-way response pad matching the E/C orientation convention used by
/// [OptotypePainter] (0=right, 90=up, 180=left, 270=down).
class OrientationResponsePad extends StatelessWidget {
  const OrientationResponsePad({super.key, required this.onSelected, this.enabled = true});

  final ValueChanged<int> onSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    Widget button(IconData icon, int orientation, String label) => IconButton.filledTonal(
          onPressed: enabled ? () => onSelected(orientation) : null,
          icon: Icon(icon),
          tooltip: label,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button(Icons.keyboard_arrow_up, 90, 'Opens up'),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            button(Icons.keyboard_arrow_left, 180, 'Opens left'),
            const SizedBox(width: 32),
            button(Icons.keyboard_arrow_right, 0, 'Opens right'),
          ],
        ),
        const SizedBox(height: 8),
        button(Icons.keyboard_arrow_down, 270, 'Opens down'),
      ],
    );
  }
}
