import 'package:flutter/material.dart';

class SeeMoreText extends StatelessWidget {
  final String text;
  final Color textColor;

  SeeMoreText(this.text, {this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
