import 'package:flutter/material.dart';
import 'package:movie_app/core/shimmer/utils/designs.dart';
import 'package:shimmer/shimmer.dart';

class ActorCardShimmer extends StatelessWidget {
  const ActorCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) =>
                  posterPlaceholder(height: 100, width: 80),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) => textPlaceholder(width: 80),
            ),
          ),
        ],
      ),
    );
  }
}
