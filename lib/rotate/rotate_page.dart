import 'dart:math';

import 'package:flutter/material.dart';

class RotatePage extends StatelessWidget {
  const RotatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RotateWidget1(),
          ],
        ),
      ),
    );
  }
}

class RotateWidget1 extends StatefulWidget {
  const RotateWidget1({Key? key}) : super(key: key);

  @override
  _RotateWidget1State createState() => _RotateWidget1State();
}

class _RotateWidget1State extends State<RotateWidget1> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  Line line = Line(start: Offset(20, 20), end: Offset(60, 0));

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller)
      ..addListener(() {
        line.ratio(animation.value);
      });

    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: _CustomPainter(
        line: line,
      ),
    );
  }
}

class _CustomPainter extends CustomPainter {
  _CustomPainter({required this.line}) : super(repaint: line);
  final Line line;

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    line.drawLine(canvas);
    drawText('角度 :${(line.positiveRad * 180 / pi).toStringAsFixed(2)}', canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.save();
    canvas.translate(60, 60);
    canvas.rotate(line.positiveRad);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: 20, height: 50), line.paint..style = PaintingStyle.stroke);

    canvas.restore();
  }

  void drawText(String text, Canvas canvas, Offset offset, {Color color = Colors.lightBlue}) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: 12, color: color),
    );
    textPainter.layout(maxWidth: 200);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _CustomPainter oldDelegate) {
    return oldDelegate.line != line;
  }
}

class Line extends ChangeNotifier {
  Line({required this.start, required this.end});

  Offset start;
  Offset end;

  final Paint paint = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  double dateRotate = 0;

  /// [rad ] 旋转的角度
  void ratio(double rad) {
    //本次旋转的角度
    dateRotate = rad - dateRotate;
    end = Offset(length * cos(rad + dateRotate), length * sin(rad + dateRotate)) + start;
    dateRotate = rad;
    notifyListeners();
  }

  void drawLine(Canvas canvas) {
    canvas.drawLine(start, end, paint);
    drawRadio(canvas, start);
    drawRadio(canvas, end);
  }

  void drawRadio(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 4, paint..style = PaintingStyle.stroke);
    canvas.drawCircle(offset, 2, paint..style = PaintingStyle.fill);
  }

  double get rad => (end - start).direction;

  double get length => (end - start).distance;

  double get positiveRad => rad < 0 ? 2 * pi + rad : rad;
}
