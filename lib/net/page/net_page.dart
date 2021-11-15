import 'package:flutter/material.dart';
import 'package:flutter_example/net/page/test_interceptors.dart';

class NetPage extends StatefulWidget {
  const NetPage({Key? key}) : super(key: key);

  @override
  _NetPageState createState() => _NetPageState();
}

class _NetPageState extends State<NetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('dio interceptors test '),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => NetTestInterceptorsPage()));
            },
          )
        ],
      ),
    );
  }
}
