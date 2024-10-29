import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_animation/models/path_sketch.dart';

class SketchPainter extends CustomPainter {
  final PathSketch sketch;
  final bool isFill;
  final double animationValue;

  SketchPainter({
    required this.sketch,
    required this.isFill,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> offsets = sketch.points;

    // Check if offsets is empty or not enough point
    if (offsets.isEmpty || offsets.length < 2) {
      return;
    }

    // Creating a path
    final path = Path();

    // Move the path to the first offset
    path.moveTo(offsets.first.dx, offsets.first.dy);

    // Interpolating through each of the offset list value
    for (int i = 1; i < offsets.length - 1; i++) {
      final p0 = offsets[i];
      final p1 = offsets[i + 1];

      path.quadraticBezierTo(
        p0.dx,
        p0.dy,
        (p0.dx + p1.dx) / 2,
        // Why did I divide: To make the curve look more smoother
        // Try out just [py]
        (p0.dy + p1.dy) / 2,
      );
    }

    // Base paint
    Paint basePaint = Paint()
      ..color = isFill ? Colors.grey : sketch.color
      ..strokeWidth = sketch.size
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, basePaint);

    // Rendering for when container is fill
    if (isFill && animationValue > 0) {
      // Creating a new paint from the [basePaint]
      Paint fillPaint = basePaint..color = sketch.color;

      // Computing the movement of the fillPaint animation
      PathMetrics pathMatrics = path.computeMetrics();
      PathMetric pathMetric = pathMatrics.first;
      Path animatePath =
          pathMetric.extractPath(0.0, pathMetric.length * animationValue);

      canvas.drawPath(animatePath, fillPaint);
    }

    // Rendering for when container is not fill
    if (!isFill && animationValue > 0) {
      Paint circlePaint = Paint()..color = sketch.color;

      canvas.drawCircle(getOffset(path, animationValue), 15, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  /// Function to get a smooth offset path for the ball motion
  Offset getOffset(Path path, double value) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.first;
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value)!;
    return pos.position;
  }
}
