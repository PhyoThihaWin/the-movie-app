import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/play_button_view.dart';

import '../widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {
  final MovieVO? movie;
  final Function(int?) onTapMovie;

  ShowCaseView({required this.movie, required this.onTapMovie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapMovie(movie?.id);
      },
      child: Container(
        margin: EdgeInsets.only(right: MARGIN_MEDIUM),
        width: 300,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                "$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
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
                      movie?.title ?? "",
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
      ),
    );
  }
}
