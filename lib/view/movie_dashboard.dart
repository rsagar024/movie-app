import 'package:flutter/material.dart';
import 'package:movie_app/core/shimmer/actor_card_shimmer.dart';
import 'package:movie_app/core/shimmer/movie_card_shimmer.dart';
import 'package:movie_app/core/shimmer/slider_shimmer.dart';
import 'package:movie_app/core/widgets/actor_card_design.dart';
import 'package:movie_app/core/widgets/movie_card_design.dart';
import 'package:movie_app/core/widgets/slider_design.dart';
import 'package:movie_app/resource/cast_list.dart';
import 'package:movie_app/resource/movie_list.dart';
import 'package:movie_app/view/movie_detail_screen.dart';
import 'package:movie_app/view_model/movie_dashboard_view_model.dart';
import 'package:provider/provider.dart';

class MovieDashboard extends StatefulWidget {
  const MovieDashboard({Key? key}) : super(key: key);

  @override
  State<MovieDashboard> createState() => _MovieDashboardState();
}

class _MovieDashboardState extends State<MovieDashboard> {
  @override
  void initState() {
    super.initState();
    Provider.of<MovieDashboardViewModel>(context, listen: false)
        .initDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<MovieDashboardViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(213, 213, 213, 1.0),
                    Colors.white,
                    Colors.white,
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ).copyWith(bottom: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.movie,
                        color: Color(0xFF979797),
                        size: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ).copyWith(left: 5),
                        child: const Text(
                          'MOVIES',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF979797),
                            fontSize: 23,
                            fontFamily: 'SF_Pro',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: ListView(
                      children: [
                        value.isLoading
                            ? const SliderShimmer()
                            : const SliderDesign(),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Popular Movies',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SF_Pro',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MovieLists(
                                      title: 'Movies',
                                      // size: 30,
                                      isSearchBar: true,
                                      isFavorite: false,
                                    ),
                                  ),
                                  (Route<dynamic> route) => true,
                                );
                              },
                              child: const Text(
                                'See more',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SF_Pro',
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// Popular Movies Poster and Details
                        value.isLoading
                            ? const MovieCardShimmer()
                            : SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: value.movie[0].length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                              movieModel: value.movie[0][index],
                                            ),
                                          ),
                                          (Route<dynamic> route) => true,
                                        );
                                      },
                                      child: MovieCardDesign(
                                        movie: value.movie[0][index],
                                        movieIndex: 0,
                                        index: index,
                                        width: 165,
                                      ),
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Popular Actor\'s',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SF_Pro',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CastLists(
                                      title: 'Casts',
                                    ),
                                  ),
                                  (Route<dynamic> route) => true,
                                );
                              },
                              child: const Text(
                                'See more',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SF_Pro',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        /// Cast Poster and Details
                        value.isLoading
                            ? const ActorCardShimmer()
                            : ActorCardDesign(
                                casts: value.cast,
                              ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 15,
                            left: 5,
                          ),
                          child: Text(
                            'Upcoming Movies',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SF_Pro',
                            ),
                          ),
                        ),
                        value.isLoading
                            ? const MovieCardShimmer()
                            : SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: value.movie[3].length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                              movieModel: value.movie[3][index],
                                            ),
                                          ),
                                          (Route<dynamic> route) => true,
                                        );
                                      },
                                      child: MovieCardDesign(
                                        movie: value.movie[3][index],
                                        movieIndex: 3,
                                        index: index,
                                        width: 165,
                                      ),
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(
                          height: 63,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
