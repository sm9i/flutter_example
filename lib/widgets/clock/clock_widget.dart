import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/scheduler.dart';

part 'clock_paint.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({Key? key, this.radius = 100}) : super(key: key);

  /// r
  final double radius;

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  late Ticker ticker;
  final ValueNotifier<DateTime> time = ValueNotifier(DateTime.now());

  @override
  void initState() {
    ticker = createTicker(_ticker)..start();
    super.initState();
  }

  void _ticker(Duration elapsed) {
    if (time.value.second != DateTime.now().second) {
      time.value = DateTime.now();
    }
  }

  @override
  void dispose() {
    time.dispose();
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            painter: _CustomBackPaint(radius: widget.radius),
          ),
          RepaintBoundary(
            child: CustomPaint(
              painter: _CustomClockPaint(
                radius: widget.radius,
                time: time,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
