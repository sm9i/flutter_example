import 'package:flutter/material.dart';

class ScrollControllerPage extends StatefulWidget {
  const ScrollControllerPage({Key? key}) : super(key: key);

  @override
  _ScrollControllerPageState createState() => _ScrollControllerPageState();
}

class _ScrollControllerPageState extends State<ScrollControllerPage> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: scrollController,
      child: Scaffold(
        key: ValueKey('sc'),
        appBar: AppBar(),
        body: ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('scroll index $index'),
            );
          },
          itemCount: 50,
        ),
      ),
    );
  }
}
