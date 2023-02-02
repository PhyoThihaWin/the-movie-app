import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class ActorView extends StatelessWidget {
  const ActorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Stack(
        children: const [
          Positioned.fill(
            child: ActorImageView(),
          ),
          Padding(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(),
          )
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  const ActorImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://celebhealthmagazine.com/wp-content/uploads/2022/09/Leonardo-DiCaprio.jpg",
      fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  const ActorNameAndLikeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM_2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Leonado DiCaprio",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: const [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM_2,
              ),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "YOU LIKE 14 MOVIES",
                style: TextStyle(
                    color: HOME_SCREEN_LIST_TITLE_COLOR,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
