import 'package:flutter/material.dart';

class FoodDetailPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) {
        return FoodDetailScreen();
      },
    );
  }
}

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlutterLogo(size: 80),
      ),
    );
  }
}
