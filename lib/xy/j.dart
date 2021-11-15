import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class _CustomPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    path.lineTo(0, 0);

    List<Offset> points = [];
    //360 度
    for (int i = 0; i < 360 * 5; i++) {
      final r = pi / 180 * i;
      final p = 30 * r;
      points.add(Offset(cos(p) * r, sin(p) * r));
    }

    canvas.drawPoints(PointMode.polygon, points, _paint);
  }

  @override
  bool shouldRepaint(covariant _CustomPainter oldDelegate) {
    return false;
  }
}
