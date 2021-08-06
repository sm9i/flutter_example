import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              controller: controller,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelPadding: EdgeInsets.symmetric(vertical: 15),
              indicatorWeight: 10,
              indicator: CustomIndicator(controller.length),
              indicatorPadding: EdgeInsets.zero,
              tabs: List.generate(
                  controller.length, (index) => Text('tab $index')).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: List.generate(controller.length,
                  (index) => Center(child: Text('tab view $index'))).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class RoundedUnderlineTabIndicator extends Decoration {
  const RoundedUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.radius,
    this.width,
  }) : assert(insets != null);

  final BorderSide borderSide;
  final EdgeInsetsGeometry? insets;
  final double? radius;
  final double? width;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is RoundedUnderlineTabIndicator) {
      return RoundedUnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
        radius: radius ?? borderSide.width * 5,
        width: width,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is RoundedUnderlineTabIndicator) {
      return RoundedUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
        radius: radius ?? borderSide.width * 5,
        width: width,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _RoundedUnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _RoundedUnderlinePainter(
      this,
      onChanged,
      radius: radius ?? borderSide.width * 5,
      width: width,
    );
  }
}

class _RoundedUnderlinePainter extends BoxPainter {
  const _RoundedUnderlinePainter(
    this.decoration,
    VoidCallback? onChanged, {
    @required this.radius,
    this.width,
  }) : super(onChanged);

  final double? radius;
  final double? width;

  final RoundedUnderlineTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;

  EdgeInsetsGeometry? get insets => decoration.insets;

  RRect _indicatorRectFor(Rect? rect, TextDirection? textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect? indicator = insets?.resolve(textDirection).deflateRect(rect!);
    return RRect.fromRectAndRadius(
      width == null
          ? Rect.fromLTWH(
              indicator!.left,
              indicator.bottom - borderSide.width,
              indicator.width,
              borderSide.width,
            )
          : Rect.fromCenter(
              center: Offset(
                indicator!.left + indicator.width / 2,
                indicator.bottom - borderSide.width,
              ),
              width: width!,
              height: borderSide.width,
            ),
      Radius.circular(radius ?? 0),
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration? configuration) {
    assert(configuration != null);
    assert(configuration?.size != null);
    final Rect rect = offset & configuration!.size!;
    final TextDirection? textDirection = configuration.textDirection;
    final RRect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width);
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.round;
    canvas.drawRRect(indicator, paint);
  }
}

class CustomIndicator extends Decoration {
  CustomIndicator(this.length);

  final int length;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomBoxPainter(length);
  }
}

class _CustomBoxPainter extends BoxPainter {
  _CustomBoxPainter(this.length);

  double trapezoidWidth = 10;
  final int length;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size!;
    final rect = offset & size;

    final backRect = Rect.fromLTRB(0, 10, size.width * length, size.height);
    final linearShader =
        ui.Gradient.linear(backRect.topCenter, backRect.bottomCenter, [
      Colors.greenAccent.withOpacity(0.8),
      Colors.greenAccent.withOpacity(0.1),
    ]);
    canvas.drawRect(
        backRect,
        Paint()
          ..color
          ..shader = linearShader);

    Path path = Path();
    double leftWidth = 0;
    double rightWidth = 0;
    final progress = (offset.dx / size.width).round();
    if (progress == 0) {
      rightWidth = trapezoidWidth;
    } else if (progress == length - 1) {
      rightWidth = 0;
      leftWidth = trapezoidWidth;
    } else {
      leftWidth = trapezoidWidth;
      rightWidth = trapezoidWidth;
    }
    path
      ..moveTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx + leftWidth, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx - rightWidth, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy);
    path.close();

    canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.fill
          ..shader = linearShader);
  }
}
