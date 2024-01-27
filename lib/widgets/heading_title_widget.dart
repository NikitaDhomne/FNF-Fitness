import 'package:flutter/material.dart';

class HeadingTitleWidget extends StatelessWidget {
  final String title;
  const HeadingTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
