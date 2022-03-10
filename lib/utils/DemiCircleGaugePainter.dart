import 'package:flutter/material.dart';

class DemiCircleGaugePainter extends CustomPainter {
  final Color gaugeColor;
  final Color thresholdColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  DemiCircleGaugePainter({required this.gaugeColor,
    required this.thresholdColor,
    required this.paintingStyle,
    required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint gaugePaint = Paint()
      ..color = this.gaugeColor
      ..style = this.paintingStyle
      ..strokeWidth = this.strokeWidth;
    Paint thresholdPaint = Paint()
      ..color = this.thresholdColor
      ..style = this.paintingStyle
      ..strokeWidth = this.strokeWidth;

    final Path demiCirclePath = Path()
      ..moveTo(0, size.height)
      ..arcToPoint(Offset(size.width, size.height), radius: Radius.circular(1));
    canvas.drawPath(demiCirclePath, gaugePaint);

    final double gaugeMarkings = size.width - (size.width * 0.925);

    canvas.drawLine(Offset(0, size.height),
        Offset(gaugeMarkings, size.height), gaugePaint);

    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, gaugeMarkings), gaugePaint);

    canvas.drawLine(Offset(size.width - gaugeMarkings, size.height),
        Offset(size.width, size.height), thresholdPaint);
  }

  @override
  bool shouldRepaint(covariant DemiCircleGaugePainter oldDelegate) {
    return oldDelegate.gaugeColor != this.gaugeColor ||
        oldDelegate.thresholdColor != this.thresholdColor;
  }

}