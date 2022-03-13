import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

import '../utils/BigArcGaugePainter.dart';

class BigArcGaugeWidget extends StatefulWidget {
  final double width;
  late double height;
  final Stream<num> valueUpdateStream;
  final num minValue;
  final num maxValue;
  final num thresholdValue;

  BigArcGaugeWidget({required this.width,
    required this.valueUpdateStream,
    required this.maxValue, required this.minValue,
    required this.thresholdValue}) {
    this.height = this.width / 2;
  }

  @override
  State<BigArcGaugeWidget> createState() => _BigArcGaugeWidgetState();
}

class _BigArcGaugeWidgetState extends State<BigArcGaugeWidget> {

  late StreamSubscription<num> _valueStreamSubscription;
  num? value;
  bool valueAboveThreshold = false;

  @override
  void initState() {
    super.initState();
    this._valueStreamSubscription = this.widget.valueUpdateStream.listen(
            (num newValue) {
              if (newValue != this.value) {
                setState(() {
                  this.value = newValue;
                  this.valueAboveThreshold = (this.value == null
                      ? false
                      : (this.value! >= this.widget.thresholdValue));
                });
              }
    });
  }

  @override
  void dispose() {
    this._valueStreamSubscription.cancel();
    super.dispose();
  }

  double gaugeAngleValue(num? gaugeValue) {
    if (gaugeValue == null) {
      return 0;
    }
    if(gaugeValue > this.widget.maxValue) {
      return 180;
    }
    else if (gaugeValue < this.widget.minValue) {
      return 0;
    }
    return ((((this.value?.toDouble() ?? 0) / this.widget.maxValue) * BigArcGaugePainter.SWEEP_ANGLE) - ((BigArcGaugePainter.SWEEP_ANGLE - BigArcGaugePainter.START_ANGLE) / 2));
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
            painter: BigArcGaugePainter(
                gaugeColor: Colors.white,
                strokeWidth: this.widget.width * 0.018,
                paintingStyle: PaintingStyle.stroke,
                thresholdColor: Colors.red
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
              offset: Offset(0, -this.widget.height * 0.3),
              child: Container(
                //duration: Duration(milliseconds: 500),
                width: this.widget.width * 0.48,
                height: this.widget.width * 0.02,
                child: Transform.translate(
                  offset: Offset(-this.widget.width * 0.48 / 2, 0),
                  child: Transform.rotate(
                    origin: Offset(((this.widget.width * 0.48)/2), 0), //this.widget.width * 0.48, this.widget.width * 0.02 / 2
                    angle: vector_math.radians(this.gaugeAngleValue(this.value)),
                    child: Container(
                      color: this.valueAboveThreshold ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: Offset(0, this.widget.height * 0.25),
              child: Container(
                width: this.widget.width * 0.35,
                height: this.widget.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                      (){
                        if (this.value == null) {
                          return 'XX';
                        }
                        if(this.value!.toString().contains('.')) {
                          return this.value!.toStringAsFixed(1);
                        }
                        return this.value!.toString();
                      }(),
                      style: TextStyle(
                          fontSize: this.widget.width * 0.2,
                          color: this.value != null ? (!this.valueAboveThreshold
                              ? Colors.green : Colors.red) : Colors.red
                      )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
