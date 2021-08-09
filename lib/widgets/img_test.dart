import 'package:flutter/material.dart';

class ImgTestWidget extends StatelessWidget {
  const ImgTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 30,
          height: 30,
          child: ClipOval(
            child: Image.network(
              'http://res.yxmf666.com/images/e623e03a41f74160b59cab907efcabed.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(50),
          ),
          transform: Matrix4.translationValues(0, -5, 0),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            'HOM',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
