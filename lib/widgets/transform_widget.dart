
import 'package:flutter/material.dart';

class TransformWidget extends StatefulWidget {
  const TransformWidget({Key? key}) : super(key: key);

  @override
  _TransformWidgetState createState() => _TransformWidgetState();
}

class _TransformWidgetState extends State<TransformWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..repeat(reverse: true);
    _animation = Tween(begin: -1.0, end: 1.0).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.skew(_controller.value, _controller.value),
              child: child,
            );
          },
          child: FlutterLogo(
            size: 100,
          ),
        ),
      ),
    );
  }
}
