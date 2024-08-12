import 'package:flutter/material.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/view/cast_detail_screen.dart';

class ActorCardDesign extends StatelessWidget {
  final List<CastInfo> casts;
  const ActorCardDesign({Key? key, required this.casts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context, index) {
          return casts[index].image != imageCheck
              ? GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CastDetailScreen(
                          id: casts[index].id,
                          isHome: true,
                        ),
                      ),
                      (Route<dynamic> route) => true,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 80,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              casts[index].image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            casts[index].name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF_Pro',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
