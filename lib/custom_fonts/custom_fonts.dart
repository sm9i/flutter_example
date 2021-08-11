import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/custom_fonts/helper.dart';

class LoadCustomFonts extends StatefulWidget {
  const LoadCustomFonts({Key? key}) : super(key: key);

  @override
  _LoadCustomFontsState createState() => _LoadCustomFontsState();
}

class _LoadCustomFontsState extends State<LoadCustomFonts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('custom fonts'),
      ),
      body: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontFamily: 'xm',
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  await downloadFonts();
                  setState(() {});
                },
                child: Text('download'),
              ),
              Text(
                '1,2,3,4,5,6,7,8,9,0',
              ),
              Text(
                '中国万岁',
              ),
              SizedBox(height: 30),
              Text('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
              //e00b956bf9846285496c54d15ad3e2d6302a4c7d6f7a09c4afd4827744d626e9
              //3917592
            ],
          ),
        ),
      ),
    );
  }
}
