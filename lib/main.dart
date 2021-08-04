import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/animation/cat_animation_test.dart';
import 'package:flutter_example/list/cache_list.dart';
import 'package:flutter_example/push/push_page.dart';
import 'package:flutter_example/widgets/actions_page.dart';
import 'package:flutter_example/widgets/swiper_wrap.dart';
import 'package:flutter_example/widgets/transform_widget.dart';

import 'layout/custom_multi_layout.dart';
import 'list/sliver_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      restorationScopeId: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(
          Icons.flutter_dash_sharp,
          color: Color(int.parse('0xff000000')),
        ),
        centerTitle: true,
      ),
      // body: CacheScrollPosition(),
      body: Scrollbar(
        child: NotificationListener(
          onNotification: (notification) {
            return true;
          },
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              ListTile(
                title: Text('cache list positioned'),
                onTap: () => goPage(CacheScrollPosition()),
              ),
              ListTile(
                title: Text('scroll view'),
                onTap: () => goPage(Interactive()),
              ),
              ListTile(
                title: Text('transform'),
                onTap: () => goPage(TransformWidget()),
              ),
              ListTile(
                title: Text('animation test'),
                onTap: () => goPage(CarAnimationTestPage()),
              ),
              ListTile(
                title: Text('open settings'),
                subtitle: Text(
                  'plugin',
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () => Platform.isAndroid
                    ? MethodChannel('app_settings').invokeMethod('open')
                    : null,
              ),
              ListTile(
                title: Text('push page'),
                onTap: () => goPage(PusPage()),
              ),
              ListTile(
                title: Text('sliver page'),
                onTap: () => goPage(SliverListPage()),
              ),
              ListTile(
                title: Text('custom multi layout page'),
                onTap: () => goPage(CustomMultiLayoutPage()),
              ),
              // ClipTestWidget(),
              // PaintZigZagWidget(),
              ListTile(
                title: Text('actions page'),
                onTap: () => goPage(ActionsPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goPage(Widget child) =>
      Navigator.push(context, CupertinoPageRoute(builder: (_) => child));
}
