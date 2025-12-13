import 'dart:math';
import 'package:flutter/material.dart';

class ScorePainter extends CustomPainter {
  final double score;
  final Color scoreColor;
  final Color remainColor;

  ScorePainter({
    required this.score,
    required this.scoreColor,
    required this.remainColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 6;
    const double gapDegrees = 16;

    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    double degToRad(double deg) => deg * pi / 180;

    final scorePaint = Paint()
      ..color = scoreColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double blueSweep = (360 * score) - gapDegrees;
    if (blueSweep < 0) blueSweep = 0;

    canvas.drawArc(rect, degToRad(-90), degToRad(blueSweep), false, scorePaint);

    final remainPaint = Paint()
      ..color = remainColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double redSweep = (360 * (1 - score)) - gapDegrees;
    if (redSweep < 0) redSweep = 0;

    double redStartDeg = -90 + blueSweep + gapDegrees;

    canvas.drawArc(
      rect,
      degToRad(redStartDeg),
      degToRad(redSweep),
      false,
      remainPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
