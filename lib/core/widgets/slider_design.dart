import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/movie_detail_screen.dart';
import 'package:movie_app/view_model/movie_dashboard_view_model.dart';
import 'package:provider/provider.dart';

class SliderDesign extends StatelessWidget {
  const SliderDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDashboardViewModel>(
      builder: (context, value, child) {
        return CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.25,
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: value.scrollMovies
              .map((movie) => GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                            movieModel: movie,
                          ),
                        ),
                        (Route<dynamic> route) => true,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[8],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: movie.backdrop,
                                width: double.infinity,
                                height:
                                    (MediaQuery.of(context).size.height * .38) *
                                        .6,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(
                                  color: Colors.grey.shade900,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'SF_Pro',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
