import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/shimmer/utils/designs.dart';
import 'package:shimmer/shimmer.dart';

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        height: MediaQuery.of(context).size.height * 0.23,
        child: CarouselSlider(
          options: CarouselOptions(
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
    );
  }
}
