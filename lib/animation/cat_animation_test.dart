import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CarAnimationTestPage extends StatefulWidget {
  const CarAnimationTestPage({Key? key}) : super(key: key);

  @override
  _CarAnimationTestPageState createState() => _CarAnimationTestPageState();
}

class _CarAnimationTestPageState extends State<CarAnimationTestPage> {
  GlobalKey bottomCar = GlobalKey();

  Overlay overlay = Overlay();

  @override
  void initState() {
    super.initState();
  }

  void onItemTap(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    Offset current = box
        .localToGlobal(Offset.zero)
        .translate(box.size.width - 30, box.size.height / 2);

    final car = bottomCar.currentContext?.findRenderObject() as RenderBox?;
    if (car == null) {
      return;
    }
    final carOffset = car.localToGlobal(Offset.zero);
    final Path path = Path();
    path.moveTo(current.dx, current.dy);

    path.quadraticBezierTo(
        current.dx, current.dy / 2, carOffset.dx, carOffset.dy);

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (_) {
      return _PathPaint(path: path, over: overlayEntry);
    });

    Overlay.of(context)?.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cat animation'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: List.generate(
              20,
              (index) => Builder(builder: (context) {
                return ListTile(
                  title: Text('item $index'),
                  onTap: () => onItemTap(context),
                  subtitle: Text(
                    'click right tag',
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Icon(
                    Icons.add_shopping_cart,
                    size: 18,
                  ),
                );
              }),
            ).toList(),
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30).copyWith(
              bottom: MediaQuery.of(context).padding.bottom,
              top: 20,
            ),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.flutter_dash,
                  color: Colors.red,
                  key: bottomCar,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PathPaint extends StatefulWidget {
  final Path path;
  final OverlayEntry over;

  _PathPaint({required this.path, required this.over})
      : super(key: ValueKey<Path>(path));

  @override
  __PathPaintState createState() => __PathPaintState();
}

class __PathPaintState extends State<_PathPaint>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late PathMetric positions;

  @override
  void initState() {
    positions = widget.path.computeMetrics().first;

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.over.remove();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pos = positions
                .getTangentForOffset(positions.length * controller.value)
                ?.position ??
            Offset(0, 0);
        return Positioned(
          left: pos.dx,
          top: pos.dy,
          child: child!,
        );
      },
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
