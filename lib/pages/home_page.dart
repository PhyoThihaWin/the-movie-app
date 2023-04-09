import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

import '../bloc/home_bloc.dart';
import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/banner_view.dart';
import '../viewitems/movie_view.dart';
import '../viewitems/showcase_view.dart';
import '../widgets/title_text.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              StreamBuilder<List<MovieVO>?>(
                  stream: _bloc.mPopularMovieListStreamController.stream,
                  builder: (context, snapshot) {
                    return BannerSectionView(
                      movieList: snapshot.data,
                      onTapMovie: (movieId) =>
                          _navigateToMovieDetailScreen(context, movieId),
                    );
                  }),
              const SizedBox(height: MARGIN_LARGE),
              StreamBuilder<List<MovieVO>>(
                  stream: _bloc.mNowPlayingMovieListStreamController.stream,
                  builder: (context, snapshot) {
                    return BestPopularMoviesAndSerialsSectionView(
                      onTapMovie: (movieId) =>
                          _navigateToMovieDetailScreen(context, movieId),
                      getNowPlayingMovies: snapshot.data,
                    );
                  }),
              const SizedBox(height: MARGIN_LARGE),
              const CheckMovieShowtimesView(),
              const SizedBox(height: MARGIN_LARGE),
              StreamBuilder<List<GenreVO>>(
                  stream: _bloc.mGenreListStreamController.stream,
                  builder: (context, genreSnapshot) {
                    return StreamBuilder<List<MovieVO>>(
                        stream: _bloc.mMovieByGenreListStreamController.stream,
                        builder: (context, snapshot) {
                          return GenreSectionView(
                            onTapMovie: (movieId) =>
                                _navigateToMovieDetailScreen(context, movieId),
                            genreList: genreSnapshot.data,
                            movieList: snapshot.data,
                            onChooseGenre: (genreId) {
                              if (genreId != null) {
                                debugPrint(genreId.toString());
                                _bloc.getMoviesByGenres(genreId);
                              }
                            },
                          );
                        });
                  }),
              const SizedBox(height: MARGIN_LARGE),
              StreamBuilder<List<MovieVO>>(
                  stream: _bloc.mTopRatedMovieListStreamController.stream,
                  builder: (context, snapshot) {
                    return ShowcasesSection(
                      topRatedMovies: snapshot.data,
                      onTapMovie: (movieId) =>
                          _navigateToMovieDetailScreen(context, movieId),
                    );
                  }),
              const SizedBox(height: MARGIN_LARGE),
              StreamBuilder<List<ActorVO>>(
                  stream: _bloc.mActorsStreamController.stream,
                  builder: (context, snapshot) {
                    return ActorsAndCreatorsSectionView(
                        BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE,
                        actors: snapshot.data);
                  }),
              const SizedBox(height: MARGIN_LARGE)
            ],
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

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? getNowPlayingMovies;

  BestPopularMoviesAndSerialsSectionView(
      {required this.onTapMovie, required this.getNowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          onTapMovie: onTapMovie,
          movieList: getNowPlayingMovies,
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: movieList?.isNotEmpty ?? false
          ? ListView.builder(
              itemCount: movieList?.length ?? 0,
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MovieView(
                    onTapMovie: onTapMovie, movie: movieList?[index]);
              },
            )
          : const Center(child: CircularProgressIndicator()),
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
