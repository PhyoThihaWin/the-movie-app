import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.play_circle_fill,
      color: BANNER_PLAY_BUTTON_COLOR,
      size: BANNER_PLAY_BUTTON_SIZE,
    );
  }
}
