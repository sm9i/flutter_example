import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/push/emoji_widget.dart';

class PusPage extends StatefulWidget {
  const PusPage({Key? key}) : super(key: key);

  @override
  _PusPageState createState() => _PusPageState();
}

class _PusPageState extends State<PusPage> {
  final TextEditingController textController = TextEditingController();

  final ValueNotifier<bool> isPadActive = ValueNotifier<bool>(false);
  final FocusNode focusNode = FocusNode();
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    textController.dispose();
    isPadActive.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void updateKeyboard(BuildContext context) {
    final double kh = MediaQuery.of(context).viewInsets.bottom;
    if (kh > 0 && kh >= _keyboardHeight) {
      isPadActive.value = false;
    }
    _keyboardHeight = math.max(kh, _keyboardHeight);
  }

  @override
  Widget build(BuildContext context) {
    RepaintBoundary();
    updateKeyboard(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: '你...',
                ),
                focusNode: focusNode,
                maxLines: null,
              ),
            ),
          ),
          toolBar(context),
          ValueListenableBuilder<bool>(
              valueListenable: isPadActive,
              builder: (context, value, child) {
                return EmojiWidget(height: _keyboardHeight, active: value);
              }),
          // ValueListenableBuilder<bool>(
          //   valueListenable: isPadActive,
          //   builder: (_, bool value, __) => SizedBox(
          //     height: value ? 0 : MediaQuery.of(context).viewInsets.bottom,
          //   ),
          // ),
        ],
      ),
    );
  }

  Container toolBar(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            onPressed: () async {
              if (isPadActive.value && focusNode.canRequestFocus) {
                focusNode.requestFocus();
              }
              if (MediaQuery.of(context).viewInsets.bottom > 0) {
                await SystemChannels.textInput
                    .invokeMethod<void>('TextInput.hide');
              } else {
                await SystemChannels.textInput
                    .invokeMethod<void>('TextInput.show');
              }
              isPadActive.value = !isPadActive.value;
            },
            icon: Icon(Icons.sports_football),
          )
        ],
      ),
    );
  }
}
