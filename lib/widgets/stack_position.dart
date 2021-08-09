import 'dart:math';

import 'package:flutter/material.dart';

// 1:1:sqrt(2)
class StackPosition extends StatelessWidget {
  StackPosition({Key? key}) : super(key: key);

  final text = TextSpan(
    text: 'Hello',
    style: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      height: 1.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: text,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();
    final w = textPainter.width + 50;
    final h = textPainter.height + 5;

    return Material(
      child: Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: ClipRect(
            child: Stack(
              children: <Widget>[
                Container(color: Colors.grey),
                Positioned(
                  top: (w - sqrt(2) * h) / sqrt(2),
                  right: 0,
                  child: Transform.rotate(
                    angle: pi / 4,
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: w,
                      height: h,
                      alignment: Alignment.center,
                      child: Text.rich(text),
                      color: Colors.redAccent.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
