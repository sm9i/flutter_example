import 'dart:math';

import 'package:flutter/material.dart';

class CustomRadioRectPage extends StatelessWidget {
  const CustomRadioRectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('custom radio rect'),
      ),
      body: Center(
        child: CustomRadioRectWidget(),
      ),
    );
  }
}

class CustomRadioRectWidget extends StatelessWidget {
  const CustomRadioRectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: _CustomPaint(),
    );
  }
}

class _CustomPaint extends CustomPainter {
  final Paint _paint = Paint()..color = Colors.greenAccent;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.transform(Matrix4.skewX(-30 * pi / 180).storage);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset.zero,
          width: size.width,
          height: size.height,
        ),
        Radius.circular(30),
      ),
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CustomPaint oldDelegate) {
    return false;
  }
}
