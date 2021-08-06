import 'package:flutter/material.dart';

class FoodListPage extends StatelessWidget {
  final void Function() goDetail;

  const FoodListPage({Key? key, required this.goDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('list in $index'),
            subtitle: Text('$index'),
            onTap: () => goDetail.call(),
            trailing: Icon(Icons.flutter_dash),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
