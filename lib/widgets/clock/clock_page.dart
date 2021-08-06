import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/clock/clock_widget.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('clock page')),
      body: Center(
        child: ClockWidget(),
      ),
    );
  }
}
