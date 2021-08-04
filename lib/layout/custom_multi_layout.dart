import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomMultiLayoutPage extends StatefulWidget {
  const CustomMultiLayoutPage({Key? key}) : super(key: key);

  @override
  _CustomMultiLayoutPageState createState() => _CustomMultiLayoutPageState();
}

class _CustomMultiLayoutPageState extends State<CustomMultiLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('custom multi'),
      ),
      body: SkewWidget(
        children: <Widget>[
          Container(width: 50, height: 50, color: Colors.red),
          Container(width: 50, height: 50, color: Colors.red),
          Container(width: 50, height: 50, color: Colors.red),
          Container(width: 50, height: 50, color: Colors.red),
          // FlutterLogo(),
        ],
      ),
    );
  }
}

class SkewWidget extends StatelessWidget {
  const SkewWidget({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _SkewDelegate(children.length),
      children: List.generate(children.length, (index) {
        return LayoutId(id: index, child: children[index]);
      }).toList(),
    );
  }
}

class _SkewDelegate extends MultiChildLayoutDelegate {
  _SkewDelegate(this.length);

  final int length;

  @override
  void performLayout(Size size) {
    final Map<int, Size> sizeMap = {};
    for (int i = 0; i < length; i++) {
      if (hasChild(i)) {
        final s = layoutChild(i, BoxConstraints.loose(size));
        sizeMap[i] = s;
        Offset offset = Offset.zero;
        for (int j = 0; j < sizeMap.length - 1; j++) {
          offset = Offset(
            offset.dx + sizeMap[j]!.width,
            offset.dy + sizeMap[j]!.height,
          );
        }
        positionChild(i, offset);
      }
    }
  }

  @override
  bool shouldRelayout(covariant _SkewDelegate oldDelegate) =>
      oldDelegate.length != length;
}
