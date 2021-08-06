import 'package:flutter/services.dart';

void getChannel() {
  MethodChannel _get = MethodChannel('/take');
  _get.invokeMethod('tag');
}
