import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/banner_view.dart';
import '../viewitems/movie_view.dart';
import '../viewitems/showcase_view.dart';
import '../widgets/title_text.dart';

class HomePage extends StatelessWidget {
  List<String> genreList = [
    "Action",
    "Adventrue",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

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
              BannerSectionView(),
              SizedBox(height: MARGIN_LARGE),
              BestPopularMoviesAndSerialsSectionView(
                () => _navigateToMovieDetailScreen(context),
              ),
              SizedBox(height: MARGIN_LARGE),
              CheckMovieShowtimesView(),
              SizedBox(height: MARGIN_LARGE),
              GenreSectionView(
                () => _navigateToMovieDetailScreen(context),
                genreList: genreList,
              ),
              SizedBox(height: MARGIN_LARGE),
              ShowcasesSection(),
              SizedBox(height: MARGIN_LARGE),
              ActorsAndCreatorsSectionView(
                  BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE),
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
  final List<String> genreList;
  final Function onTapMovie;

  GenreSectionView(this.onTapMovie, {required this.genreList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: BANNER_PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map(
                    (genre) => Tab(
                      child: Text(genre),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(onTapMovie),
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
  const ShowcasesSection({
    Key? key,
  }) : super(key: key);

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
            children: [
              const ShowCaseView(),
              const ShowCaseView(),
              const ShowCaseView(),
            ],
          ),
        ),
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function onTapMovie;

  BestPopularMoviesAndSerialsSectionView(this.onTapMovie);

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
        HorizontalMovieListView(onTapMovie),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function onTapMovie;

  HorizontalMovieListView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MovieView(onTapMovie);
        },
      ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  const BannerSectionView({Key? key}) : super(key: key);

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
            children: const [
              BannerView(),
              BannerView(),
              BannerView(),
            ],
          ),
        ),
        SizedBox(height: MARGIN_SMALL),
        DotsIndicator(
          dotsCount: 3,
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
