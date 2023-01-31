import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class TitleText extends StatelessWidget {
  final String text;

  TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: HOME_SCREEN_LIST_TITLE_COLOR,
          fontSize: TEXT_REGULAR,
          fontWeight: FontWeight.bold),
    );
  }
}
