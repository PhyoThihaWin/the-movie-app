import 'package:flutter/material.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

import '../data/vos/actor_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/actor_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;
  final List<ActorVO>? actors;

  ActorsAndCreatorsSectionView(this.titleText, this.seeMoreText,
      {this.seeMoreButtonVisibility = true, required this.actors});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(
        top: MARGIN_MEDIUM_2,
        bottom: MARGIN_XXLARGE,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithSeeMoreView(
              titleText,
              seeMoreText,
              seeMoreButtonVisibility: this.seeMoreButtonVisibility,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2),
          Container(
            height: BEST_ACTOR_HEIGHT,
            child: ListView(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              children: this
                      .actors
                      ?.map((actor) => ActorView(actor: actor))
                      .toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}
