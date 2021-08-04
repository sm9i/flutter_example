import 'package:flutter/material.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({Key? key}) : super(key: key);

  @override
  _ActionsPageState createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  Model model = Model();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('actions'),
      ),
      body: Center(
        child: Actions(
          actions: <Type, Action<Intent>>{
            ModelIntent: ModelAction(model),
            SaveIntent: SaveAction(model),
          },
          child: Builder(builder: (context) {
            return Row(
              children: <Widget>[
                Spacer(),
                Column(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Actions.invoke(context, ModelIntent(++count));
                      },
                      icon: Icon(Icons.exposure_plus_1),
                    ),
                    AnimatedBuilder(
                      animation: model.data,
                      builder: (context, child) {
                        return Text('${model.data.value}');
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        Actions.invoke(context, ModelIntent(--count));
                      },
                      icon: Icon(Icons.exposure_minus_1),
                    ),
                  ],
                ),
                Spacer(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class Model {
  ValueNotifier<bool> isDirty = ValueNotifier<bool>(false);
  ValueNotifier<int> data = ValueNotifier<int>(0);

  int save() {
    return 0;
  }

  void setValue(int newValue) {
    isDirty.value = data.value != newValue;
    data.value = newValue;
  }
}

class ModelIntent extends Intent {
  const ModelIntent(this.value);

  final int value;
}

class ModelAction extends Action<ModelIntent> {
  ModelAction(this.model);

  final Model model;

  @override
  void invoke(covariant ModelIntent intent) {
    model.setValue(intent.value);
  }
}

class SaveIntent extends Intent {
  const SaveIntent();
}

class SaveAction extends Action<SaveIntent> {
  SaveAction(this.model);

  final Model model;

  @override
  void invoke(covariant SaveIntent intent) {
    model.save();
  }
}
