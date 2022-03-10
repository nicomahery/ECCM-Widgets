import 'dart:async';
import 'dart:math';

import 'package:eccm_widget/utils/DemiCircleGaugePainter.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class DemiCircularGaugeWidget extends StatefulWidget {
  final double width;
  late double height;
  final Stream<num> valueUpdateStream;
  final num minValue;
  final num maxValue;
  final num thresholdValue;

  DemiCircularGaugeWidget({required this.width,
    required this.valueUpdateStream,
    required this.maxValue, required this.minValue,
    required this.thresholdValue}) {
    this.height = this.width / 2;
  }

  @override
  State<DemiCircularGaugeWidget> createState() => _DemiCircularGaugeWidgetState();
}

class _DemiCircularGaugeWidgetState extends State<DemiCircularGaugeWidget> {

  late StreamSubscription<num> _valueStreamSubscription;
  num? value;

  @override
  void initState() {
    super.initState();
    this._valueStreamSubscription = this.widget.valueUpdateStream.listen(
            (num newValue) {
              setState(() {
                this.value = newValue;
              });
    });
  }

  @override
  void dispose() {
    this._valueStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width,
      height: this.widget.height,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          CustomPaint(
            size: Size(this.widget.width, this.widget.height),
            painter: DemiCircleGaugePainter(
                gaugeColor: Colors.white,
                strokeWidth: this.widget.width * 0.018,
                paintingStyle: PaintingStyle.stroke,
                thresholdColor: Colors.red
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
              offset: Offset(0, this.widget.height * 0.17),
              child: Container(
                width: this.widget.width * 0.35,
                height: this.widget.height * 0.35,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.green,
                    width: this.widget.width * 0.01
                  )
                ),
                child: Center(
                  child: Text(
                      this.value?.toString() ?? 'XX',
                      style: TextStyle(
                          fontSize: this.widget.width * 0.12,
                          color: this.value != null ? Colors.white : Colors.red
                      )
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //offset: Offset((this.widget.width * 0.465)/2, 0),
              child: AnimatedContainer(
                transform: Matrix4Transform().rotateDegrees(170).matrix4,
                //transform: Matrix4.rotationZ(vector_math.radians(240)),
                duration: Duration(milliseconds: 500),
                color: Colors.green,
                width: this.widget.width * 0.48,
                height: this.widget.width * 0.02,
              ),
            ),
          )
        ],
      ),
    );
  }
}
