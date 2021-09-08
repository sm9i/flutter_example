import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/animation/cat_animation_test.dart';
import 'package:flutter_example/lifecycle/lifecycle_test.dart';
import 'package:flutter_example/list/cache_list.dart';
import 'package:flutter_example/list/refresh_page.dart';
import 'package:flutter_example/navigator2/home.dart';
import 'package:flutter_example/push/push_page.dart';
import 'package:flutter_example/rotate/rotate_page.dart';
import 'package:flutter_example/scroll_controller/sroll_controller_page.dart';
import 'package:flutter_example/widgets/actions_page.dart';
import 'package:flutter_example/widgets/bottom_input.dart';
import 'package:flutter_example/widgets/canvas_radio_rect.dart';
import 'package:flutter_example/widgets/clock/clock_page.dart';
import 'package:flutter_example/widgets/frame_image.dart';
import 'package:flutter_example/widgets/hero_test.dart';
import 'package:flutter_example/widgets/indicator_test.dart';
import 'package:flutter_example/widgets/ratio_progress_widget.dart';
import 'package:flutter_example/widgets/swiper_wrap.dart';
import 'package:flutter_example/widgets/transform_widget.dart';

import 'animation/cross_fade.dart';
import 'animation/custom_loading.dart';
import 'custom_fonts/custom_fonts.dart';
import 'input/input_test.dart';
import 'layout/custom_multi_layout.dart';
import 'list/sliver_list.dart';
import 'widgets/stack_position.dart';

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
      navigatorObservers: [RouteObserver<ModalRoute<void>>()],
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
              // ImgTestWidget(),
              ListTile(
                title: Text('rotate test'),
                onTap: () => goPage(RotatePage()),
              ),
              ListTile(
                title: Text('refresh test'),
                onTap: () => goPage(RefreshPage()),
              ),
              ListTile(
                title: Text('frame image test'),
                onTap: () => goPage(FrameImagePage()),
              ),
              ListTile(
                title: Text('scroll controller test'),
                onTap: () => goPage(ScrollControllerPage()),
              ),
              ListTile(
                title: Text('lifecycle test'),
                onTap: () => goPage(LifecyclePage()),
              ),
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
                onTap: () => Platform.isAndroid ? MethodChannel('app_settings').invokeMethod('open') : null,
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
              ListTile(
                title: Text('hero test page'),
                onTap: () => goPage(RadialExpansionDemo()),
                onLongPress: () {
                  timeDilation = 1.0;
                },
              ),
              ListTile(
                title: Text('tab bar test page'),
                onTap: () => goPage(TabBarPage()),
              ),
              ListTile(
                title: Text('custom loading animation page'),
                onTap: () => goPage(CustomLoadingPage()),
              ),
              ListTile(
                title: Text('navigator 2 '),
                onTap: () {
                  runApp(HomeApp());
                },
              ),
              ListTile(
                title: Text('clock page'),
                onTap: () => goPage(ClockPage()),
              ),
              ListTile(
                title: Text('cross fade page'),
                onTap: () => goPage(CrossFade()),
              ),
              ListTile(
                title: Text('stack position'),
                onTap: () => goPage(StackPosition()),
              ),
              ListTile(
                title: Text('show bottom input'),
                onTap: () => showBottomInput(context),
              ),
              ListTile(
                title: Text('progress page '),
                onTap: () => goPage(RatioProgressPage()),
              ),
              ListTile(
                title: Text('custom radio rect page '),
                onTap: () => goPage(CustomRadioRectPage()),
              ),
              ListTile(
                title: Text('custom fonts'),
                onTap: () => goPage(LoadCustomFonts()),
              ),
              ListTile(
                title: Text('input test '),
                onTap: () => goPage(InputTest()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goPage(Widget child) => Navigator.push(context, CupertinoPageRoute(builder: (_) => child));
}
