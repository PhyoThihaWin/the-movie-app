import 'package:flutter/material.dart';

import 'see_more_text.dart';
import 'title_text.dart';

class TitleTextWithSeeMoreView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;

  TitleTextWithSeeMoreView(this.titleText, this.seeMoreText);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      TitleText("SHOWCASES"),
      Spacer(),
      SeeMoreText("MORE SHOWCASES")
    ]);
  }
}
