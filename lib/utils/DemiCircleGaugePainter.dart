import 'dart:math';

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
  num degToRad(num deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    Paint gaugePaint = Paint()
      ..color = this.gaugeColor
      ..style = this.paintingStyle
      ..strokeWidth = this.strokeWidth;

    final Path demiCirclePath = Path()
      ..moveTo(0, size.height)
      ..arcToPoint(Offset(size.width, size.height), radius: Radius.circular(1))
      ..close();
    canvas.drawPath(demiCirclePath, gaugePaint);

    final double gaugeMarkings = size.width - (size.width * 0.97);

    final Path firstMarkingPath = Path()
        ..moveTo(0, size.height)
        ..lineTo(gaugeMarkings, size.height)
        ..close();
    canvas.drawPath(firstMarkingPath, gaugePaint);

    final Path secondMarkingPath = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width / 2, gaugeMarkings)
      ..close();
    canvas.drawPath(secondMarkingPath, gaugePaint);

    final Path thirdMarkingPath = Path()
      ..moveTo(size.width - gaugeMarkings, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(thirdMarkingPath, gaugePaint);
  }

  @override
  bool shouldRepaint(covariant DemiCircleGaugePainter oldDelegate) {
    return oldDelegate.gaugeColor != this.gaugeColor ||
        oldDelegate.thresholdColor != this.thresholdColor;
  }

}