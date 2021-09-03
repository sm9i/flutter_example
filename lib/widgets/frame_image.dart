import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const String img_url = 'https://s3.bmp.ovh/imgs/2021/09/f177ea648319bf9c.gif';

class FrameController extends ChangeNotifier {
  final List<FrameInfo> frame = <FrameInfo>[];
  final HttpClient httpClient = HttpClient()..autoUncompress = false;

  void loadImg() async {
    try {
      final uri = Uri.parse(img_url);

      final HttpClientRequest request = await httpClient.getUrl(uri);

      final HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        final Codec code = await PaintingBinding.instance!.instantiateImageCodec(bytes);
        for (int i = 0; i < code.frameCount; i++) {
          add(await code.getNextFrame());
        }
      } else {
        print('status code  error ${response.statusCode}');
      }
    } catch (e) {
      print('catch $e');
    }
  }

  void add(FrameInfo frameInfo) {
    frame.add(frameInfo);
    notifyListeners();
  }

  @override
  void dispose() {
    for (final info in frame) {
      info.image.dispose();
    }
    super.dispose();
  }
}

class FrameImagePage extends StatefulWidget {
  const FrameImagePage({Key? key}) : super(key: key);

  @override
  _FrameImagePageState createState() => _FrameImagePageState();
}

class _FrameImagePageState extends State<FrameImagePage> {
  final FrameController controller = FrameController();

  @override
  void initState() {
    controller.loadImg();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image frame'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomPaint(
              painter: _FrameCustom(controller),
            )
          ],
        ),
      ),
    );
  }
}

class _FrameCustom extends CustomPainter {
  _FrameCustom(this.controller) : super(repaint: controller);
  final FrameController controller;

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    if (controller.frame.isNotEmpty) {
      for (int i = 0; i < controller.frame.length; i++) {
        final img = controller.frame[i].image;
        canvas.drawImage(
          img,
          Offset(
            size.width / 2 - img.width / 2,
            (i == 0 ? 0.0 : controller.frame[i - 1].image.height).toDouble(),
          ),
          _paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _FrameCustom oldDelegate) => oldDelegate.controller != controller;
}
