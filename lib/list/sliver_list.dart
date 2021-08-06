import 'package:flutter/material.dart';

class SliverListPage extends StatefulWidget {
  const SliverListPage({Key? key}) : super(key: key);

  @override
  _SliverListPageState createState() => _SliverListPageState();
}

class _SliverListPageState extends State<SliverListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // flexibleSpace: FlexibleSpaceBar(
            //   title: Text('收件箱'),
            //   centerTitle: false,
            // ),
            flexibleSpace: FlexibleSpaceBar.createSettings(
              currentExtent: 100,
              child: AppBar(
                title: Text('2'),
              ),
            ),

            expandedHeight: 100,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('title'),
              ),
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
