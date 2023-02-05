import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../widgets/sliver_app_bar_title.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> genreList = ["Action", "Adventure", "Drama"];

    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetallsSliverAppBarView(() => Navigator.pop(context)),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MARGIN_MEDIUM_2,
                    ),
                    child: TralierSectionView(genreList),
                  ),
                  SizedBox(height: MARGIN_MEDIUM),
                  ActorsAndCreatorsSectionView(
                    MOVIE_DETAIL_SCREEN_ACOTRS_TITLE,
                    "",
                    seeMoreButtonVisibility: false,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_LARGE),
                    child: AboutFilmSectionView(),
                  ),
                  ActorsAndCreatorsSectionView(
                    MOVIE_DETAIL_SCREEN_CREATORS_TITLE,
                    MOVIE_DETAIL_SCREEN_CREATORS_SEEMORE,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  const AboutFilmSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Original Title",
          "X-Men Orgins Wolverine",
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Type",
          "Action, Adventure, Thriller",
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Production",
          "United Kingdom, USA",
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Premire",
          "8 December 2016(World)",
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Description",
          "The Wolverine was released by 20th Century Fox in various international markets on July 24, 2013, and in the United States two days later. The Wolverine was released by 20th Century Fox in various international markets on July 24, 2013, and in the United States two days later.",
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
      ],
    );
  }
}

class AboutFlimInfoView extends StatelessWidget {
  final String label;
  final String description;

  AboutFlimInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
                color: MOVIE_DETAIL_SCREEN_INFO_TEXT_COLOR,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class TralierSectionView extends StatelessWidget {
  final List<String> genreList;

  TralierSectionView(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(height: MARGIN_MEDIUM_3),
        MovieStoryLineView(),
        SizedBox(height: MARGIN_MEDIUM_3),
        Row(
          children: [
            MovieDetailTrailerButtonView(
              "PLAY TRAILER",
              BANNER_PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle,
                color: Colors.black45,
                size: MARGIN_XLARGE,
              ),
            ),
            SizedBox(width: MARGIN_MEDIUM),
            MovieDetailTrailerButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: BANNER_PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )
      ],
    );
  }
}

/// Play Trailer and Rate Movie Button
class MovieDetailTrailerButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailTrailerButtonView(
      this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border: (isGhostButton)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            SizedBox(width: MARGIN_SMALL),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR),
            )
          ],
        ),
      ),
    );
  }
}

class MovieStoryLineView extends StatelessWidget {
  const MovieStoryLineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAIL_SCREEN_STORYLINE_TITLE),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "Lured to a Japan he hasn't seen since World War II, century-old mutant Wolverine (Hugh Jackman) finds himself in a shadowy realm of yakuza and samurai. Wolverine is pushed to his physical and emotional brink when he is forced to go on the run with a powerful industrialist's daughter (Tao Okamoto) and is confronted -- for the first time -- with the prospect of death. As he struggles to rediscover the hero within himself, he must grapple with powerful foes and the ghosts of his own haunted past.",
          style: TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: BANNER_PLAY_BUTTON_COLOR,
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          "2h 30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Row(
          children: genreList.map((genre) => GenreChipView(genre)).toList(),
        ),
        Spacer(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          backgroundColor: MOVIE_DETAIL_SCREEN_CHIP_BG_COLOR,
          label: Text(
            genreText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: MARGIN_SMALL)
      ],
    );
  }
}

class MovieDetallsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;

  MovieDetallsSliverAppBarView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: SliverAppBarTitle(child: Text("The Wolverine")),
      centerTitle: true,
      pinned: true,

      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAIL_SCREEN_SLIVER_APPBAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  top: MARGIN_XXLARGE,
                ),
                child: BackButtonView(onTapBack),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: MARGIN_MEDIUM_2,
                  top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE,
                ),
                child: MovieDetailsAppBarInfoView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const MovieDetailsYearView(),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RatingView(),
                    const SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText(
                      "38876 VOTES",
                    ),
                    const SizedBox(
                      height: MARGIN_MEDIUM,
                    )
                  ],
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                const Text(
                  "9,76",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAIL_RATING_TEXT_SIZE,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        const Text(
          "The Wolverine",
          style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_2X,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  const MovieDetailsYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
        color: BANNER_PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: const Center(
          child: Text(
        "2016",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTabBack;

  BackButtonView(this.onTabBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTabBack(),
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://wallpaperaccess.com/full/1191269.jpg",
      fit: BoxFit.cover,
    );
  }
}
