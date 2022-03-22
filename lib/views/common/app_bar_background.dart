import 'package:flutter/material.dart';

class MyAppBarBackground extends StatelessWidget {
  const MyAppBarBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.lightGreen, Colors.cyan]),
        ),);
  }
}
