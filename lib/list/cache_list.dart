import 'package:flutter/material.dart';

class CacheScrollPosition extends StatefulWidget {
  const CacheScrollPosition({Key? key}) : super(key: key);

  @override
  _CacheScrollPositionState createState() => _CacheScrollPositionState();
}

class _CacheScrollPositionState extends State<CacheScrollPosition> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        restorationId: 'cache id',
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('tag for $index'),
            tileColor: index % 2 == 0 ? Colors.red : Colors.blue,
            subtitle: Text('subtitle for $index'),
          );
        },
        itemCount: 200,
      ),
    );
  }
}
