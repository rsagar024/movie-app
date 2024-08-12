import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/view_model/movie_dashboard_view_model.dart';
import 'package:provider/provider.dart';

class MovieCardDesign extends StatelessWidget {
  final int? index;
  final int? movieIndex;
  final double? height;
  final double width;
  final MovieModel movie;
  const MovieCardDesign(
      {Key? key,
      this.index,
      this.movieIndex,
      this.height,
      required this.width,
      required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: null,
      width: width,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            movie.poster,
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
                          movie.voteAverage.toStringAsFixed(1),
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
                      onTap: () => Provider.of<MovieDashboardViewModel>(context,
                              listen: false)
                          .updateFavorite(index!, movieIndex!),
                      child: movie.favorite == 1
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
    );
  }
}
