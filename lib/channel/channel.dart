import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void getChannel() {
  MethodChannel _get = MethodChannel('/take');
  _get.invokeMethod('tag');
}
