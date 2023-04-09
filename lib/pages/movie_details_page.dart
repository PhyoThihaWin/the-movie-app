import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/vos/movie_vo.dart';
import '../widgets/sliver_app_bar_title.dart';

class MovieDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MovieModelImpl>(
        builder: (context, child, model) {
          return Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: CustomScrollView(
              slivers: [
                MovieDetallsSliverAppBarView(
                  () => Navigator.pop(context),
                  movieDetails: model.mMovie,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2,
                        ),
                        child: TralierSectionView(
                          genreList:
                              model.mMovie?.getGenreListAsStringList() ?? [],
                          storyLine: model.mMovie?.overview ?? "",
                        ),
                      ),
                      const SizedBox(height: MARGIN_MEDIUM),
                      ActorsAndCreatorsSectionView(
                        MOVIE_DETAIL_SCREEN_ACOTRS_TITLE,
                        "",
                        seeMoreButtonVisibility: false,
                        actors: model.mActorList,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_2,
                            vertical: MARGIN_LARGE),
                        child: AboutFilmSectionView(
                          movieDetails: model.mMovie,
                        ),
                      ),
                      ActorsAndCreatorsSectionView(
                        MOVIE_DETAIL_SCREEN_CREATORS_TITLE,
                        MOVIE_DETAIL_SCREEN_CREATORS_SEEMORE,
                        actors: model.mCreatorList,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? movieDetails;

  AboutFilmSectionView({required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Original Title",
          movieDetails?.title ?? "",
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Type",
          movieDetails?.getGenreListAsCommaSeparatedString() ?? "",
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Production",
          movieDetails?.getProductionCountriesAsCommaSeparatedString() ?? "",
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Premire",
          movieDetails?.releaseDate ?? "",
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView("Description", movieDetails?.overview ?? ""),
        const SizedBox(height: MARGIN_MEDIUM_2),
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
            style: const TextStyle(
                color: MOVIE_DETAIL_SCREEN_INFO_TEXT_COLOR,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
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
  final String storyLine;

  TralierSectionView({required this.genreList, required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        const SizedBox(height: MARGIN_MEDIUM_3),
        MovieStoryLineView(
          storyLine: storyLine,
        ),
        const SizedBox(height: MARGIN_MEDIUM_3),
        Row(
          children: [
            MovieDetailTrailerButtonView(
              "PLAY TRAILER",
              BANNER_PLAY_BUTTON_COLOR,
              const Icon(
                Icons.play_circle,
                color: Colors.black45,
                size: MARGIN_XLARGE,
              ),
            ),
            const SizedBox(width: MARGIN_MEDIUM),
            MovieDetailTrailerButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              const Icon(
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
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
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
            const SizedBox(width: MARGIN_SMALL),
            Text(
              title,
              style: const TextStyle(
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
  final String storyLine;

  MovieStoryLineView({required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAIL_SCREEN_STORYLINE_TITLE),
        const SizedBox(height: MARGIN_MEDIUM),
        Text(
          storyLine,
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
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(
          Icons.access_time,
          color: BANNER_PLAY_BUTTON_COLOR,
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        const Text(
          "2h 30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        ...genreList.map((genre) => GenreChipView(genre)).toList(),
        const Spacer(),
        const Icon(
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAIL_SCREEN_CHIP_BG_COLOR,
          label: Text(
            genreText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_SMALL)
      ],
    );
  }
}

class MovieDetallsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movieDetails;

  MovieDetallsSliverAppBarView(this.onTapBack, {required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: SliverAppBarTitle(child: const Text("The Wolverine")),
      centerTitle: true,
      pinned: true,
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAIL_SCREEN_SLIVER_APPBAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child:
                  MovieDetailsAppBarImageView(movieDetails?.posterPath ?? ""),
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
                child: MovieDetailsAppBarInfoView(
                  movie: movieDetails,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  final MovieVO? movie;

  MovieDetailsAppBarInfoView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(
              year: movie?.releaseDate?.substring(0, 4) ?? "",
            ),
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
                      "${movie?.voteCount} VOTES",
                    ),
                    const SizedBox(
                      height: MARGIN_MEDIUM,
                    )
                  ],
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  movie?.voteAverage.toString() ?? "",
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
        Text(
          movie?.title ?? "",
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
  final String year;

  MovieDetailsYearView({required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
        color: BANNER_PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Center(
          child: Text(
        year,
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
  final String imageUrl;

  MovieDetailsAppBarImageView(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
      fit: BoxFit.cover,
    );
  }
}
