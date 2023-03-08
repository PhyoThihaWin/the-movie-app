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
  /// State Variables
  List<MovieVO>? getNowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenres;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  MovieModel movieModel = MovieModelImpl();

  @override
  void initState() {
    /// Now Playing Movies
    movieModel.getNowPlayingMovies(1).then((list) {
      setState(() {
        getNowPlayingMovies = list;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Popular Movies
    movieModel.getNowPlayingMovies(1).then((list) {
      setState(() {
        popularMovies = list.sublist(0, list.length ~/ 2.8);
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Genres
    movieModel.getGenres().then((list) {
      setState(() {
        this.genres = list;
      });
      movieModel.getMoviesByGenre(genres?.first.id ?? 1).then((list) {
        setState(() {
          moviesByGenres = list;
        });
      }).catchError((error) {
        debugPrint(error.toString());
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Top Rated Movies
    movieModel.getTopRatedMovies(1).then((list) {
      setState(() {
        topRatedMovies = list;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Actors
    movieModel.getActors(1).then((list) {
      setState(() {
        actors = list;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    super.initState();
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
              BannerSectionView(
                movieList: popularMovies,
              ),
              SizedBox(height: MARGIN_LARGE),
              BestPopularMoviesAndSerialsSectionView(
                onTapMovie: () => _navigateToMovieDetailScreen(context),
                getNowPlayingMovies: getNowPlayingMovies,
              ),
              SizedBox(height: MARGIN_LARGE),
              CheckMovieShowtimesView(),
              SizedBox(height: MARGIN_LARGE),
              GenreSectionView(
                onTapMovie: () => _navigateToMovieDetailScreen(context),
                genreList: genres,
                movieList: moviesByGenres,
              ),
              SizedBox(height: MARGIN_LARGE),
              ShowcasesSection(topRatedMovies: topRatedMovies),
              SizedBox(height: MARGIN_LARGE),
              ActorsAndCreatorsSectionView(
                  BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE,
                  actors: actors),
              SizedBox(height: MARGIN_LARGE)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToMovieDetailScreen(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsPage(),
        ));
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? movieList;
  final Function onTapMovie;

  GenreSectionView(
      {required this.onTapMovie,
      required this.genreList,
      required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
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
                          child: Text(genre?.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(
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

  ShowcasesSection({required this.topRatedMovies});

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
                    ?.map((movie) => ShowCaseView(movie: movie))
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function onTapMovie;
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
  final Function onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: movieList != null
          ? ListView.builder(
              itemCount: movieList?.length ?? 0,
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MovieView(
                    onTapMovie: onTapMovie, movie: movieList?[index]);
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO>? movieList;

  BannerSectionView({required this.movieList});

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
                        ))
                    .toList() ??
                [],
          ),
        ),
        SizedBox(height: MARGIN_SMALL),
        DotsIndicator(
          dotsCount: widget.movieList?.length ?? 1,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: BANNER_PLAY_BUTTON_COLOR,
          ),
        )
      ],
    );
  }
}
