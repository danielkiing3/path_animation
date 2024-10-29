import 'package:flutter/material.dart';

/// Class to model the drawn path on the screen
class PathSketch {
  /// The offset coordinate of the point
  final List<Offset> points;

  /// Colors of the canvas stroke
  final Color color;

  /// Stroke width of the paint
  final double size;

  PathSketch({
    required this.points,
    this.color = Colors.white,
    this.size = 4,
  });
}
