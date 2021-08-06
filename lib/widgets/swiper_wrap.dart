import 'package:flutter/material.dart';

class Interactive extends StatefulWidget {
  const Interactive({Key? key}) : super(key: key);

  @override
  _InteractiveState createState() => _InteractiveState();
}

class _InteractiveState extends State<Interactive> {
  final m4 = Matrix4.identity();
  late TransformationController _controller;

  @override
  void initState() {
    _controller = TransformationController();
    _controller.addListener(() => _controller.value);
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
      child: InteractiveViewer(
        transformationController: _controller,
        onInteractionEnd: (detail) {
          print(_controller.value);
        },
        maxScale: 10,
        minScale: 0.1,
        child: Stack(
          children: <Widget>[
            Center(
              child: Image.network(
                  'http://res.yxmf666.com/images/e623e03a41f74160b59cab907efcabed.png'),
            ),
            // Title(color: Colors.red, child: Text('title'))
          ],
        ),
      ),
    );
  }
}
