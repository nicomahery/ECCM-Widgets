import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class BigArcGaugePainter extends CustomPainter {
  final Color gaugeColor;
  final Color thresholdColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double thresholdPercentage;
  static double START_ANGLE = 140;
  static double SWEEP_ANGLE = 220;

  BigArcGaugePainter({required this.gaugeColor,
    required this.thresholdColor,
    required this.paintingStyle,
    required this.strokeWidth,
    required this.thresholdPercentage
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double heightOffset = size.width * 0.15;
    Paint gaugePaint = Paint()
      ..color = this.gaugeColor
      ..style = this.paintingStyle
      ..strokeWidth = this.strokeWidth;
    Paint thresholdPaint = Paint()
      ..color = this.thresholdColor
      ..style = this.paintingStyle
      ..strokeWidth = this.strokeWidth;

    final circleRect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height - heightOffset),
        width: size.width, height: size.width);

    final Path demiCirclePath = Path()
      ..addArc(circleRect, radians(140), radians(220));
      //..arcToPoint(Offset(size.width, size.height), radius: Radius.elliptical(1, 1.5));
    canvas.drawPath(demiCirclePath, gaugePaint);

    final double gaugeMarkings = size.width - (size.width * 0.925);

    canvas.drawLine(Offset(0, size.height - heightOffset),
        Offset(gaugeMarkings, size.height - heightOffset), gaugePaint);

    canvas.drawLine(Offset(size.width / 2, 0 - heightOffset),
        Offset(size.width / 2, gaugeMarkings - heightOffset), gaugePaint);

    canvas.drawLine(Offset(size.width - gaugeMarkings, size.height - heightOffset),
        Offset(size.width, size.height - heightOffset), thresholdPaint);
    double thresholdStartAngle = START_ANGLE + (SWEEP_ANGLE * this.thresholdPercentage);
    canvas.drawArc(circleRect, radians(thresholdStartAngle), radians(360 - thresholdStartAngle), false, thresholdPaint);
  }

  @override
  bool shouldRepaint(covariant BigArcGaugePainter oldDelegate) {
    return oldDelegate.gaugeColor != this.gaugeColor ||
        oldDelegate.thresholdColor != this.thresholdColor;
  }

}