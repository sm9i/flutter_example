import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WaveProgressWidget extends StatefulWidget {
  const WaveProgressWidget({Key? key, this.size = 200}) : super(key: key);

  final double size;

  @override
  _WaveProgressWidgetState createState() => _WaveProgressWidgetState();
}

class _WaveProgressWidgetState extends State<WaveProgressWidget> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController progress;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    progress = AnimationController(vsync: this, duration: Duration(milliseconds: 4000));

    controller.repeat();
    progress.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.reset();
    progress.reset();
    controller.dispose();
    progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CustomPainter(controller, progress),
      size: Size(widget.size, widget.size),
    );
  }
}

class _CustomPainter extends CustomPainter {
  _CustomPainter(this.animation, this.progress)
      : super(
          repaint: Listenable.merge([animation, progress]),
        );
  final Animation animation;
  final Animation progress;

  final Paint _paint = Paint()
    ..color = Colors.orange
    ..strokeWidth = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);

    // canvas.drawRect(
    //   Rect.fromCenter(
    //     center: Offset.zero,
    //     width: size.width / 2,
    //     height: size.height / 2,
    //   ),
    //   _paint,
    // );

    final waveWidth = size.width / 2;
    final waveHeight = waveWidth / 2;
    canvas.save();
    canvas.translate(-3 * waveWidth, size.height / 2);
    Path path = Path();
    path.moveTo(0, 0);

    path.relativeQuadraticBezierTo(waveWidth / 2, -waveHeight, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, -waveHeight, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight, waveWidth, 0);
    path.relativeLineTo(0, size.height);
    path.relativeLineTo(-waveWidth * 4, 0);
    canvas.translate(waveWidth * 2 * animation.value, -size.height * progress.value);
    canvas.drawPath(path, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CustomPainter oldDelegate) {
    return oldDelegate.animation != animation && oldDelegate.progress != progress;
  }
}
