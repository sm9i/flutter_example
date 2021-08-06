part of 'clock_widget.dart';

class _CustomClockPaint extends CustomPainter {
  _CustomClockPaint({required this.radius, required this.time})
      : super(repaint: time);

  final double radius;
  final ValueNotifier<DateTime> time;

  final Paint _paint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    drawArrow(canvas, time.value);
  }

  void drawArrow(Canvas canvas, DateTime time) {
    final hour = time.hour;
    final second = time.second;
    final minute = time.minute;

    //表示1秒的度数
    final preAnge = 360 / 60;
    //秒针的度数  1秒站用了1格
    final secondRad = second * preAnge / 180 * pi;
    //分钟  1分钟占 1格 加 剩余的秒
    final minuteRad = (minute + second / 60) * preAnge / 180 * pi;
    //小时  1小时占用 5格 加上 分钟和秒
    final hourRad =
        (hour + minute / 60 + second / 3600) * preAnge * 5 / 180 * pi;
    canvas.save();
    //当前12点是在3点方向 所以反转 90度
    canvas.rotate(-pi / 2);

    //时
    canvas.save();
    canvas.rotate(hourRad);
    drawHour(canvas);
    canvas.restore();

    //分
    canvas.save();
    canvas.rotate(minuteRad);
    drawMinute(canvas);
    canvas.restore();

    //秒
    canvas.save();
    canvas.rotate(secondRad);
    drawSecond(canvas);
    canvas.restore();

    canvas.restore();
  }

  void drawSecond(Canvas canvas) {
    ///绘制中心绿圆
    _paint
      ..color = Colors.lightGreen
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, minusLineWidth * 2, _paint);

    final s = 45;
    _paint
      ..strokeWidth = minusLineWidth
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    ///绘制中心圆
    canvas.drawCircle(Offset.zero, minusLineWidth * 2, _paint);

    ///绘制弧形 大约是[s] 度
    canvas.drawArc(
      Rect.fromCenter(
          center: Offset.zero,
          width: minusLineWidth * 8,
          height: minusLineWidth * 8),
      s / 180 * pi,
      (360 - s * 2) / 180 * pi,
      false,
      _paint,
    );

    ///绘制针屁股 是 弧形width的一半
    canvas.drawLine(Offset(-minusLineWidth * 4, 0),
        Offset(-minusLineWidth * 2 - 20, 0), _paint);

    _paint..strokeWidth = secondLineWidth;

    ///绘制指针
    canvas.drawLine(
        Offset(minusLineWidth * 2, 0), Offset(secondLen, 0), _paint);
  }

  void drawMinute(Canvas canvas) {
    _paint
      ..color = Colors.lightGreen
      ..strokeWidth = minusLineWidth;
    canvas.drawLine(Offset.zero, Offset(minusLen, 0), _paint);
  }

  void drawHour(Canvas canvas) {
    _paint
      ..color = Colors.lightGreenAccent
      ..strokeWidth = hourLineWidth;
    canvas.drawLine(Offset.zero, Offset(hourLen, 0), _paint);
  }

  @override
  bool shouldRepaint(covariant _CustomClockPaint oldDelegate) {
    return oldDelegate.time != time || oldDelegate.radius != radius;
  }

  double get logic1 => radius * 0.01;

  double get minusLen => logic1 * 60; // 分针长
  double get hourLen => logic1 * 45; // 时针长
  double get secondLen => logic1 * 68; // 秒针长
  double get hourLineWidth => logic1 * 3; // 时针线宽
  double get minusLineWidth => logic1 * 2; // 分针线宽
  double get secondLineWidth => logic1; // 秒针线宽

  double get scaleSpace => logic1 * 11; // 刻度与外圈的间隔
  double get shortScaleLen => logic1 * 7; // 短刻度线长
  double get shortLenWidth => logic1; // 短刻度线长
  double get longScaleLen => logic1 * 11; // 长刻度线长
  double get longLineWidth => logic1 * 2; // 长刻度线宽
}

class _CustomBackPaint extends CustomPainter {
  _CustomBackPaint({required this.radius});

  final double radius;

  final Paint _paint = Paint()..style = PaintingStyle.stroke;

  final TextPainter _textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  final Paint _outArcPaint = Paint()
    ..strokeWidth = 4
    ..color = Color(0xff00abf2)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    drawOutCircle(canvas);
    drawScale(canvas);
    drawText(canvas);
  }

  void drawText(Canvas canvas) {
    _drawOutCircleText(canvas, 'Ⅲ', offsetX: radius);
    _drawOutCircleText(canvas, 'Ⅸ', offsetX: -radius);
    _drawOutCircleText(canvas, 'Ⅵ', offsetY: radius);
    _drawOutCircleText(canvas, 'Ⅻ', offsetY: -radius);
    drawLogo(canvas);
  }

  void drawLogo(Canvas canvas) {
    _textPainter.text = TextSpan(
      text: 'Flutter',
      style: TextStyle(
        fontSize: radius / 6,
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
    _textPainter.layout();
    _textPainter.paint(
        canvas, Offset.zero.translate(-_textPainter.width / 2, -radius * 0.5));
  }

  void _drawOutCircleText(
    Canvas canvas,
    String text, {
    double offsetX = 0,
    double offsetY = 0,
  }) {
    _textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: radius * 0.15, color: Colors.blue),
    );
    _textPainter.layout();
    //中心画好后然后 平移到offsetXY的位置 减去text宽高的一半
    _textPainter.paint(
      canvas,
      Offset.zero.translate(
        offsetX - _textPainter.size.width / 2,
        offsetY - _textPainter.height / 2,
      ),
    );
  }

  void drawScale(Canvas canvas) {
    _paint
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    //60秒
    double count = 60;
    //一次转多少度
    double perAngle = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      //遇到分钟
      if (i % 5 == 0) {
        _paint
          ..strokeWidth = longLineWidth
          ..color = Colors.blue;
        canvas.drawLine(
          Offset(radius - scaleSpace, 0),
          Offset(radius - scaleSpace - longScaleLen, 0),
          _paint,
        );
        canvas.drawCircle(
            Offset(radius - scaleSpace - longScaleLen - logic1 * 5, 0),
            longLineWidth,
            _paint..color = Colors.orange);
      } else {
        _paint
          ..strokeWidth = shortLenWidth
          ..color = Colors.black;
        canvas.drawLine(
          Offset(radius - scaleSpace, 0),
          Offset(radius - scaleSpace - shortScaleLen, 0),
          _paint,
        );
      }

      //绘制完后转
      canvas.rotate(perAngle);
    }
  }

  void drawOutCircle(Canvas canvas) {
    for (int i = 0; i < 4; i++) {
      _drawArc(canvas);
      canvas.rotate(pi / 2);
    }
  }

  /// 绘制外圈弧
  void _drawArc(Canvas canvas) {
    _outArcPaint.maskFilter = MaskFilter.blur(BlurStyle.solid, logic1);

    final Path circlePath = Path()
      ..addArc(
          Rect.fromCenter(
              center: Offset.zero, width: radius * 2, height: radius * 2),
          10 / 180 * pi,
          pi / 2 - 20 / 180 * pi);
    Path circlePath2 = Path()
      ..addArc(
          Rect.fromCenter(
              center: Offset(-logic1, 0),
              width: radius * 2,
              height: radius * 2),
          10 / 180 * pi,
          pi / 2 - 20 / 180 * pi);
    //联合路径
    Path result =
        Path.combine(PathOperation.difference, circlePath, circlePath2);
    canvas.drawPath(result, _outArcPaint); //绘制

    // canvas.drawArc(
    //     Rect.fromCenter(
    //       center: Offset.zero,
    //       width: radius * 2,
    //       height: radius * 2,
    //     ),
    //     10 / 180 / math.pi,
    //     math.pi / 2 - 20 / 180 * math.pi,
    //     false,
    //     _outArcPaint);
    // canvas.drawArc(
    //     Rect.fromCenter(
    //       center: Offset(-logic1, 0),
    //       width: radius * 2,
    //       height: radius * 2,
    //     ),
    //     10 / 180 / math.pi,
    //     math.pi / 2 - 20 / 180 * math.pi,
    //     false,
    //     _outArcPaint);
  }

  @override
  bool shouldRepaint(covariant _CustomBackPaint oldDelegate) =>
      oldDelegate.radius != radius;

  double get logic1 => radius * 0.01;

  double get minusLen => logic1 * 60; // 分针长
  double get hourLen => logic1 * 45; // 时针长
  double get secondLen => logic1 * 68; // 秒针长
  double get hourLineWidth => logic1 * 3; // 时针线宽
  double get minusLineWidth => logic1 * 2; // 分针线宽
  double get secondLineWidth => logic1; // 秒针线宽

  double get scaleSpace => logic1 * 11; // 刻度与外圈的间隔
  double get shortScaleLen => logic1 * 7; // 短刻度线长
  double get shortLenWidth => logic1; // 短刻度线长
  double get longScaleLen => logic1 * 11; // 长刻度线长
  double get longLineWidth => logic1 * 2; // 长刻度线宽
}
