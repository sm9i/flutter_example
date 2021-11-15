import 'package:flutter/material.dart';
import 'package:flutter_example/net/net_util.dart';

class NetTestInterceptorsPage extends StatefulWidget {
  const NetTestInterceptorsPage({Key? key}) : super(key: key);

  @override
  _NetTestInterceptorsPageState createState() => _NetTestInterceptorsPageState();
}

class _NetTestInterceptorsPageState extends State<NetTestInterceptorsPage> {
  @override
  void initState() {
    super.initState();
  }

  void get(String url) {
    NetClient().get(url).then((value) {
      print('success');
    }).catchError((e) {
      print('error---$e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              get('getWangYiNews?page=1&count=5');
            },
            title: Text('success'),
          ),
          ListTile(
            onTap: () {
              get('getWangYiNews?page=d&count=5');
            },
            title: Text('error'),
          ),
        ],
      ),
    );
  }
}
