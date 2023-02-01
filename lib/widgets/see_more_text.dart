import 'package:flutter/material.dart';

class SeeMoreText extends StatelessWidget {
  final String text;

  SeeMoreText(this.text);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "MORE SHOWCASES",
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline),
    );
  }
}
