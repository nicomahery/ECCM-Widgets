import 'package:eccm_widget/utils/DemiCircleGaugePainter.dart';
import 'package:flutter/material.dart';

class DemiCircularGaugeWidget extends StatefulWidget {
  final double width;
  final double height;
  final Stream<num> valueUpdateStream;
  final num minValue;
  final num maxValue;
  final num thresholdValue;

  DemiCircularGaugeWidget({required this.width, required this.height,
    required this.valueUpdateStream,
    required this.maxValue, required this.minValue,
    required this.thresholdValue});

  @override
  State<DemiCircularGaugeWidget> createState() => _DemiCircularGaugeWidgetState();
}

class _DemiCircularGaugeWidgetState extends State<DemiCircularGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width,
      height: this.widget.height,
      child: CustomPaint(
        painter: DemiCircleGaugePainter(
            gaugeColor: Colors.white,
            strokeWidth: 5,
            paintingStyle: PaintingStyle.stroke,
            thresholdColor: Colors.red
        ),
        child:  Text('Test', style: TextStyle(fontSize: 4, color: Colors.white)),
      ),
    );
  }
}
