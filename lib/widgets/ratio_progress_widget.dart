import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/canvas_radio_rect.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatioProgressPage extends StatelessWidget {
  const RatioProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _RatioProgressWidget(),
      ),
    );
  }
}

class _RatioProgressWidget extends StatefulWidget {
  const _RatioProgressWidget({Key? key}) : super(key: key);

  @override
  __RatioProgressWidgetState createState() => __RatioProgressWidgetState();
}

class __RatioProgressWidgetState extends State<_RatioProgressWidget> {
  double current = 0.0;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: CustomRadioRectWidget(),
        );
        // return ClipPath(
        //   clipper: _CustomClip(),
        //   child: Container(
        //     color: Colors.blue,
        //     width: 30,
        //     height: 30,
        //   ),
        // );
      },
      minRating: 1,
      unratedColor: Color(0xffefefef),
      glow: false,
      itemSize: 30,
      itemCount: 10,
      itemPadding: EdgeInsets.symmetric(horizontal: 0),
      onRatingUpdate: (index) {
        if (current == index) {
          return;
        }
        current = index;
        setState(() {});
      },
      updateOnDrag: true,
    );
  }
}

class _CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(10, 0);
    path.lineTo(size.width, 0);

    path.lineTo(size.width - 10, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
