import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTest extends StatelessWidget {
  const InputTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          color: Color(0x91a6feda),
          width: 300,
          height: 130,
          child: InputWidget(),
        ),
      ),
    );
  }
}

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> implements TextInputClient {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final TextStyle textStyle = TextStyle(
    color: Colors.red,
    fontSize: 14,
  );
  late TextInputConnection connection;

  final TextEditingValue editingValue = TextEditingValue();

  @override
  void initState() {
    connection = TextInput.attach(this, TextInputConfiguration());
    connection.setEditingState(editingValue);
    super.initState();
  }

  @override
  void dispose() {
    connection.close();
    controller.dispose();
    focusNode.dispose();

    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('did change dependencies');
  }

  @override
  Widget build(BuildContext context) {
    // return EditableText(
    //   controller: controller,
    //   focusNode: focusNode,
    //   style: textStyle,
    //   cursorColor: Colors.blueAccent,
    //   backgroundCursorColor: Color(0xffdedede),
    //   maxLines: 30,
    // );
    ///没 删除
    return GestureDetector(
      onTap: () {
        print(editingValue.text);
        connection.show();
      },
      child: Container(
        width: 200,
        height: 130,
        color: Colors.grey,
      ),
    );
  }

  @override
  void connectionClosed() {}

  @override
  AutofillScope? get currentAutofillScope => null;

  @override
  TextEditingValue? get currentTextEditingValue => editingValue;

  @override
  void performAction(TextInputAction action) {
    print('performAction');
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {}

  @override
  void showAutocorrectionPromptRect(int start, int end) {}

  @override
  void updateEditingValue(TextEditingValue value) {
    print(value);
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    print('updateFloatingCursor');
  }
}
