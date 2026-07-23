import 'package:flutter/material.dart';

/// Which forced-choice optotype form is being rendered (Task.md §14).
enum OptotypeShape { tumblingE, landoltC }

/// Renders a single Tumbling E or Landolt C optotype at an exact pixel size
/// (Task.md §10: sizing itself must always come from [OptotypeSizing] — this
/// widget only draws the geometry it is given, never invents its own size).
///
/// [orientationDeg] is the direction the E's open side / C's gap faces:
/// 0 = right, 90 = up (screen-up), 180 = left, 270 = down. Rotation is
/// implemented as a canvas transform so a single stroke path serves every
/// orientation.
class OptotypePainter extends CustomPainter {
  const OptotypePainter({
    required this.shape,
    required this.heightPx,
    required this.strokePx,
    required this.orientationDeg,
    required this.ink,
    required this.paper,
  });

  final OptotypeShape shape;
  final double heightPx;
  final double strokePx;
  final int orientationDeg;
  final Color ink;
  final Color paper;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()..color = paper;
    canvas.drawRect(Offset.zero & size, background);

    final Paint fg = Paint()
      ..color = ink
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    // Canvas rotation is clockwise-positive; screen-up (90) should rotate
    // counter-clockwise, so negate.
    canvas.rotate(-orientationDeg * 3.14159265358979 / 180);
    canvas.translate(-heightPx / 2, -heightPx / 2);

    if (shape == OptotypeShape.tumblingE) {
      _paintE(canvas, fg);
    } else {
      _paintC(canvas, fg);
    }
    canvas.restore();
  }

  /// Classic 5x5-unit block-E: three horizontal bars + one vertical spine,
  /// each [strokePx] thick, all opening to the right (orientation 0).
  void _paintE(Canvas canvas, Paint fg) {
    final double s = strokePx;
    final double h = heightPx;
    // Vertical spine (left edge).
    canvas.drawRect(Rect.fromLTWH(0, 0, s, h), fg);
    // Three horizontal arms.
    canvas.drawRect(Rect.fromLTWH(0, 0, h, s), fg);
    canvas.drawRect(Rect.fromLTWH(0, (h - s) / 2, h, s), fg);
    canvas.drawRect(Rect.fromLTWH(0, h - s, h, s), fg);
  }

  /// Landolt C: a ring of outer diameter [heightPx] and thickness [strokePx],
  /// with a [strokePx]-wide gap cut on the right side (orientation 0).
  void _paintC(Canvas canvas, Paint fg) {
    final double h = heightPx;
    final double s = strokePx;
    final Rect bounds = Rect.fromLTWH(0, 0, h, h);
    final Path ring = Path()
      ..addOval(bounds)
      ..addOval(bounds.deflate(s))
      ..fillType = PathFillType.evenOdd;
    canvas.save();
    canvas.clipPath(ring);
    canvas.drawRect(bounds, fg);
    canvas.restore();

    // Cut the gap: a paper-colored wedge on the right side, gap width = s.
    final Paint cut = Paint()..color = paper;
    final Rect gapRect = Rect.fromLTWH(h - s, (h - s) / 2, s, s);
    canvas.drawRect(gapRect, cut);
  }

  @override
  bool shouldRepaint(covariant OptotypePainter oldDelegate) =>
      oldDelegate.shape != shape ||
      oldDelegate.heightPx != heightPx ||
      oldDelegate.strokePx != strokePx ||
      oldDelegate.orientationDeg != orientationDeg ||
      oldDelegate.ink != ink ||
      oldDelegate.paper != paper;
}

/// Convenience widget wrapping [OptotypePainter] in a sized [CustomPaint].
class OptotypeView extends StatelessWidget {
  const OptotypeView({
    super.key,
    required this.shape,
    required this.heightPx,
    required this.strokePx,
    required this.orientationDeg,
    this.ink = Colors.black,
    this.paper = Colors.white,
  });

  final OptotypeShape shape;
  final double heightPx;
  final double strokePx;
  final int orientationDeg;
  final Color ink;
  final Color paper;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: shape == OptotypeShape.tumblingE
          ? 'Tumbling E optotype, use the arrow buttons to answer'
          : 'Landolt C optotype, use the arrow buttons to answer',
      child: CustomPaint(
        size: Size(heightPx, heightPx),
        painter: OptotypePainter(
          shape: shape,
          heightPx: heightPx,
          strokePx: strokePx,
          orientationDeg: orientationDeg,
          ink: ink,
          paper: paper,
        ),
      ),
    );
  }
}
