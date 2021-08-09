import 'package:flutter/material.dart';

class CrossFade extends StatelessWidget {
  const CrossFade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cross fade'),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => _FadeItem(index: index),
        itemCount: 30,
      ),
    );
  }
}

class _FadeItem extends StatefulWidget {
  const _FadeItem({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  __FadeItemState createState() => __FadeItemState();
}

class __FadeItemState extends State<_FadeItem> {
  CrossFadeState state = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('${widget.index}'),
          subtitle: Text('tap '),
          trailing: Icon(
            state == CrossFadeState.showFirst
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_up,
          ),
          onTap: () {
            state = state == CrossFadeState.showFirst
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst;
            setState(() {

            });
          },
        ),
        AnimatedCrossFade(
          firstChild: SizedBox.shrink(),
          secondChild: item,
          crossFadeState: state,
          duration: Duration(milliseconds: 500),
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget get item => GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) {
          return FlutterLogo(
            size: 30,
          );
        },
        itemCount: 3,
      );
}
