import 'dart:math';

import 'package:flutter/material.dart';

class IndexOffsetCurve extends Curve {
  const IndexOffsetCurve(this.index);

  final int index;

  @override
  double transform(double t) {
    double p = pow(t, (index + 1) * 2).toDouble();
    return p;
  }
}
