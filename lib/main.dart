// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_to_pdf/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Image to PDF',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
