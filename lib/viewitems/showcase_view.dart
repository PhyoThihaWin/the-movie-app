import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/play_button_view.dart';

import '../widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://fictionhorizon.com/wp-content/uploads/2021/09/Wolverine-Movies-in-Order-All-X-Logan-Movies-Order-09.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Passenger",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: TEXT_REGULAR_3X),
                  ),
                  SizedBox(height: MARGIN_SMALL),
                  TitleText("15 DECEMBER 2016"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
