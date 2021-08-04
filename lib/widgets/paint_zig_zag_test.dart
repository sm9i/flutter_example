import 'package:flutter/material.dart';

class PaintZigZagWidget extends StatelessWidget {
  const PaintZigZagWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(200, 100),
        painter: _CustomPaint(),
      ),
    );
  }
}

class _CustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    // canvas.drawCircle(Offset.zero, 10, Paint());
    // paintBorder(
    //   canvas,
    //   Rect.fromCenter(center: Offset.zero, width: 100, height: 100),
    //   top: BorderSide(color: Colors.red),
    //   bottom: BorderSide(color: Colors.red),
    //   right: BorderSide(color: Colors.red),
    //   left: BorderSide(color: Colors.red),
    // );
    // paintZigZag(canvas, Paint(), Offset.zero, Offset(0, 100), 10, 40);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
