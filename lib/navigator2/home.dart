import 'package:flutter/material.dart';
import 'package:flutter_example/navigator2/detail.dart';
import 'package:flutter_example/navigator2/list.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  bool showDetail = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'navigator 2',
      home: Navigator(
        pages: [
          MaterialPage(child: FoodListPage(
            goDetail: () {
              showDetail = true;
              setState(() {});
            },
          )),
          if (showDetail) FoodDetailPage(),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          setState(() {});
          showDetail = false;
          return true;
        },
      ),
    );
  }
}
