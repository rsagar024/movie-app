import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/movie_detail_screen.dart';
import 'package:movie_app/view_model/movie_dashboard_view_model.dart';
import 'package:provider/provider.dart';

class MovieCardDesign extends StatelessWidget {
  final int movieIndex;
  const MovieCardDesign({Key? key, required this.movieIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDashboardViewModel>(
      builder: (context, value, child) {
        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: value.movie[movieIndex].length,
            itemBuilder: (context, index) {
              // bool fav=false;
              return GestureDetector(
                onTap: () {
                  // print('Clicked $index');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        // id: _movie[movieIndex][index].id,
                        movieModel: value.movie[movieIndex][index],
                      ),
                    ),
                    (Route<dynamic> route) => true,
                  );
                },
                child: Container(
                  width: 165,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        value.movie[movieIndex][index].poster,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlurryContainer(
                              blur: 1,
                              color: Colors.black38,
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 7,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFFFC31A),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Text(
                                      // '7.2',
                                      value.movie[movieIndex][index].voteAverage
                                          .toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SF_Pro',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 15,
                              ),
                              child: BlurryContainer(
                                blur: 1,
                                color: Colors.black38,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                child: GestureDetector(
                                  onTap: () =>
                                      value.updateFavorite(index, movieIndex),
                                  child:
                                      value.movie[movieIndex][index].favorite ==
                                              1
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                ),
                              ),
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
      },
    );
  }
}
