import 'package:flutter/material.dart';
import 'package:flutter_example/list/refresh/refresh_widget.dart';

class RefreshPage extends StatefulWidget {
  const RefreshPage({Key? key}) : super(key: key);

  @override
  _RefreshPageState createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshWidget<UserInfo>(
        fetchData: (int pageIndex) async {
          //get data
          return Future.delayed(Duration(milliseconds: 2342), () {
            if (pageIndex == 1) {
              return [
                UserInfo(age: '19'),
                UserInfo(age: '20'),
                UserInfo(age: '21'),
                UserInfo(name: 'Lqo Tuna · Func a'),
              ];
            }
            return [
              UserInfo(name: 'last ', age: '8-8'),
            ];
          });
        },
        builder: (context, List<UserInfo> value) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(value[index].name),
                subtitle: Text(value[index].age),
              );
            },
            itemCount: value.length,
          );
        },
      ),
    );
  }
}

class UserInfo {
  UserInfo({this.name = 'Andy', this.age = '18'});

  final String name;
  final String age;
}
