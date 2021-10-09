import 'dart:math';

import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  const StarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CustomPaint(
          painter: _CustomPainter(),
          size: Size(200, 200),
        ),
      ),
    );
  }
}

class _CustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..strokeWidth = 0.1
      ..style = PaintingStyle.stroke;
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset.zero, size.width / 2, _paint);
    canvas.drawCircle(Offset.zero, 1, _paint..style = PaintingStyle.fill);
    // 72
    final double r = 360 / 5 * 2;

    final radius = size.width / 2;
    final path = Path();

    canvas.save();
    canvas.rotate(-pi / 2);

    for (int i = 0; i < 5; i++) {
      Offset offset = Offset(cos(pi / 180 * r * i) * radius, sin(pi / 180 * r * i) * radius);
      if (i == 0) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
    }
    path.close();
    canvas.drawPath(path, _paint..style = PaintingStyle.stroke);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CustomPainter oldDelegate) {
    return false;
  }
}
