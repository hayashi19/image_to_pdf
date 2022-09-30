import 'package:flutter/material.dart';
import 'package:image_to_pdf/pages/convert.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).padding.left + 10,
          top: MediaQuery.of(context).padding.top + 10,
          right: MediaQuery.of(context).padding.right + 10,
          bottom: MediaQuery.of(context).padding.bottom + 10,
        ),
        child: const ConvertPage(),
      ),
    );
  }
}
