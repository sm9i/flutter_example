import 'dart:math';

import 'package:flutter/material.dart';

// 1:1:sqrt(2)
class StackPosition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: _StackP(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.redAccent,
          ),
          text: 'Geo m',
        ),
      ),
    );
  }
}

class _StackP extends StatelessWidget {
  _StackP({
    Key? key,
    required this.child,
    required String text,
    TextStyle? style,
  })  : text = TextSpan(text: text, style: style),
        super(key: key);

  final TextSpan text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: text,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();
    final w = textPainter.width + 40;
    final h = textPainter.height + 5;
    return ClipRect(
      child: Stack(
        children: <Widget>[
          child,
          Positioned(
            // top: (w - sqrt(2) * h) / sqrt(2),
            // w/sqrt(2) - h
            //WSBT
            top: w / sqrt(2) - h,
            right: 0,
            child: Transform.rotate(
              angle: pi / 4,
              alignment: Alignment.bottomRight,
              child: Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff83EA91),
                      Color(0xff3CBD48),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                alignment: Alignment.center,
                child: Text.rich(text),
                // color: Colors.redAccent.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
