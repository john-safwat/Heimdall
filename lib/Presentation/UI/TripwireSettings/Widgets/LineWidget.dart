import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;
  final double strokeWidth;

  LinePainter({required this.start, required this.end, this.color = Colors.black, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) =>
      oldDelegate.start != start || oldDelegate.end != end ||
          oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}