import 'dart:ui';

import 'package:flutter/material.dart';

//数据信息
class Line {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  Line({
    required this.points,
    this.color = Colors.black,
    this.strokeWidth = 1,
  });
}
