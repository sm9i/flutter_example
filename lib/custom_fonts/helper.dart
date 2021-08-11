import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

final fontUrl =
    'https://fonts.gstatic.com/s/a/e00b956bf9846285496c54d15ad3e2d6302a4c7d6f7a09c4afd4827744d626e9.ttf';

Future<void> downloadFonts() async {
  final cache = await getTemporaryDirectory();
  final filePath = '${cache.path}/xw1.ttf';
  if (await File(filePath).exists()) {
    print('file is exists');
    return loadFile(filePath);
  }
  await Dio().download(fontUrl, filePath, onReceiveProgress: (count, total) {
    print(count / total);
  });
  return loadFile(filePath);
}

void loadFile(String path) async {
  final file = File(path);
  if (!file.existsSync()) {
    return;
  }
  final loader = FontLoader('xm');

  loader.addFont(
    file.readAsBytes().then<ByteData>((value) => ByteData.view(value.buffer)),
  );
  await loader.load();
  return;
}
