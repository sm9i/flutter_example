import 'package:flutter/material.dart';

class ClipTestWidget extends StatelessWidget {
  const ClipTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: _CustomCLip(),
        child: Container(
          color: Colors.red,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}


class _CustomCLip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
