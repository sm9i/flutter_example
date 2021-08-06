import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomLoadingPage extends StatefulWidget {
  const CustomLoadingPage({Key? key}) : super(key: key);

  @override
  _CustomLoadingPageState createState() => _CustomLoadingPageState();
}

class _CustomLoadingPageState extends State<CustomLoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final tween = DecorationTween(
      begin: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 1),
                color: Colors.purple,
                blurRadius: 5,
                spreadRadius: 2)
          ]),
      end: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 1),
                color: Colors.blue,
                blurRadius: 10,
                spreadRadius: 0)
          ]));

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.repeat();
    });
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
      body: Center(
        child: IconTheme(
          data: IconThemeData(color: Colors.lightGreen, size: 40),
          child: Wrap(
            spacing: 20,
            children: [
              RotationTransition(
                turns: controller,
                child: dash,
              ),
              ScaleTransition(
                scale: controller,
                child: dash,
              ),
              SlideTransition(
                position: Tween(
                  begin: Offset(-0.5, 0),
                  end: Offset(0.5, 0),
                ).animate(controller),
                child: dash,
              ),
              AlignTransition(
                alignment: Tween(
                        begin: Alignment.bottomCenter, end: Alignment.topRight)
                    .animate(controller),
                child: dash,
              ),
              DecoratedBoxTransition(
                decoration: tween.animate(controller),
                child: dash,
              ),
              DrawerHeader(child: dash),
            ],
          ),
        ),
      ),
    );
  }

  Icon get dash => Icon(Icons.flutter_dash);
}
