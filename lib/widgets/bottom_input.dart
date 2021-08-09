import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showBottomInput(BuildContext context) {
  MethodChannel(name).invokeMethod(method)
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return _BottomWidget();
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class _BottomWidget extends StatefulWidget {
  const _BottomWidget({Key? key}) : super(key: key);

  @override
  __BottomWidgetState createState() => __BottomWidgetState();
}

class __BottomWidgetState extends State<_BottomWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: _controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: 'input',
              isDense: true,
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
        ],
      ),
    );
  }
}
