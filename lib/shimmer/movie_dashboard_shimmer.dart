import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shimmer/utils/designs.dart';
import 'package:shimmer/shimmer.dart';

class MovieDashboardShimmer extends StatelessWidget {
  const MovieDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: ListView(
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
                Container(
                  margin: const EdgeInsets.only(top: 10,),
                  height: MediaQuery.of(context).size.height*0.23,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      // height: MediaQuery.of(context).size.height * 0.25,
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      scrollingPlaceholder(context),
                      scrollingPlaceholder(context),
                      scrollingPlaceholder(context),
                    ],
                  ),
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
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        posterPlaceholder(height: 220, width: 165),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Popular Actor\'s',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF_Pro',
                      ),
                    ),
                    Text(
                        'See more',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF_Pro',
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) =>
                          posterPlaceholder(height: 100, width: 80),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
