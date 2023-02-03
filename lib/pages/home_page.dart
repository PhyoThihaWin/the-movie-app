import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/viewitems/actor_view.dart';
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
  const HomePage({Key? key}) : super(key: key);

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
              const BannerSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              const BestPopularMoviesAndSerialsSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              CheckMovieShowtimesView(),
              const SizedBox(height: MARGIN_LARGE),
              const HorizontalMovieListView(),
              const SizedBox(height: MARGIN_LARGE),
              const ShowcasesSection(),
              const SizedBox(height: MARGIN_LARGE),
              const BestActorSectionView(),
              const SizedBox(height: MARGIN_LARGE)
            ],
          ),
        ),
      ),
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

class BestActorSectionView extends StatelessWidget {
  const BestActorSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child:
              TitleTextWithSeeMoreView(BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Container(
          height: BEST_ACTOR_HEIGHT,
          child: ListView(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: [
              const ActorView(),
              const ActorView(),
              const ActorView(),
            ],
          ),
        ),
      ],
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
  const BestPopularMoviesAndSerialsSectionView({
    Key? key,
  }) : super(key: key);

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
        const HorizontalMovieListView(),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  const HorizontalMovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const MovieView();
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
