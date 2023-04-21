import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/home_bloc.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import 'package:provider/provider.dart';

import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/banner_view.dart';
import '../viewitems/showcase_view.dart';
import '../widgets/title_and_horizontal_movie_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          title: const Text(
            MAIN_SCREEN_APP_BAR_TITLE,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          leading: const Icon(Icons.menu),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.popularMovies,
                  builder: (context, value, child) {
                    return BannerSectionView(
                      movieList: value,
                      onTapMovie: (movieId) =>
                          _navigateToMovieDetailScreen(context, movieId),
                    );
                  },
                ),
                const SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.getNowPlayingMovies,
                  builder: (context, value, child) {
                    return TitleAndHorizontalMovieListView(
                      (movieId) =>
                          _navigateToMovieDetailScreen(context, movieId),
                      value,
                      title: MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS,
                      onListEndReached: () {
                        var bloc =
                            Provider.of<HomeBloc>(context, listen: false);
                        bloc.onNowPlayingMovieListEndReached();
                      },
                    );
                  },
                ),
                const SizedBox(height: MARGIN_LARGE),
                const CheckMovieShowtimesView(),
                const SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<GenreVO>?>(
                  selector: (context, bloc) => bloc.genres,
                  builder: (context, value, child) {
                    return Selector<HomeBloc, List<MovieVO>?>(
                      selector: (context, bloc) => bloc.moviesByGenres,
                      builder: (context, moviesByGenre, child) {
                        return GenreSectionView(
                          onTapMovie: (movieId) =>
                              _navigateToMovieDetailScreen(context, movieId),
                          genreList: value,
                          movieList: moviesByGenre,
                          onChooseGenre: (genreId) {
                            if (genreId != null) {
                              debugPrint(genreId.toString());
                              HomeBloc bloc =
                                  Provider.of<HomeBloc>(context, listen: false);
                              bloc.getMoviesByGenres(genreId);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.topRatedMovies,
                  builder: (context, value, child) {
                    return ShowcasesSection(
                      topRatedMovies: value,
                      onTapMovie: (movieId) =>
                          _navigateToMovieDetailScreen(context, movieId),
                    );
                  },
                ),
                const SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<ActorVO>?>(
                  selector: (context, bloc) => bloc.actors,
                  builder: (context, value, child) {
                    return ActorsAndCreatorsSectionView(
                        BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE,
                        actors: value);
                  },
                ),
                const SizedBox(height: MARGIN_LARGE)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(
              movieId: movieId,
            ),
          ));
    }
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? movieList;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenre;

  GenreSectionView(
      {required this.onTapMovie,
      required this.genreList,
      required this.movieList,
      required this.onChooseGenre});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: BANNER_PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map(
                        (genre) => Tab(
                          child: Text(genre.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
              onTap: (index) {
                onChooseGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: const EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(
            onTapMovie: onTapMovie,
            movieList: movieList,
            onListEndReached: () {},
          ),
        ),
      ],
    );
  }
}

class CheckMovieShowtimesView extends StatelessWidget {
  const CheckMovieShowtimesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: SHOWTIMES_SECTION_HEIGHT,
      padding: const EdgeInsets.all(MARGIN_LARGE),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEEMORE,
                textColor: BANNER_PLAY_BUTTON_COLOR,
              )
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          )
        ],
      ),
    );
  }
}

class ShowcasesSection extends StatelessWidget {
  final List<MovieVO>? topRatedMovies;
  final Function(int?) onTapMovie;

  ShowcasesSection({required this.topRatedMovies, required this.onTapMovie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithSeeMoreView(SHOWCASES_TITLE, SHOWCASES_SEE_MORE),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: SHOWCASES_HEIGHT,
          child: ListView(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: topRatedMovies
                    ?.map((movie) => ShowCaseView(
                          movie: movie,
                          onTapMovie: onTapMovie,
                        ))
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO>? movieList;
  final Function(int?) onTapMovie;

  BannerSectionView({required this.onTapMovie, required this.movieList});

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  var _position = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                _position = index.toDouble();
              });
            },
            children: widget.movieList
                    ?.map((movie) => BannerView(
                          movie: movie,
                          onTapMovie: widget.onTapMovie,
                        ))
                    .toList() ??
                [],
          ),
        ),
        const SizedBox(height: MARGIN_SMALL),
        DotsIndicator(
          dotsCount: widget.movieList?.length ?? 1,
          position: _position,
          decorator: const DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: BANNER_PLAY_BUTTON_COLOR,
          ),
        )
      ],
    );
  }
}
