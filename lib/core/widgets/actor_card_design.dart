import 'package:flutter/material.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/screens/cast_detail_screen.dart';
import 'package:movie_app/view_model/movie_dashboard_view_model.dart';
import 'package:provider/provider.dart';

class ActorCardDesign extends StatelessWidget {
  const ActorCardDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDashboardViewModel>(
      builder: (context, value, child) {
        return SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: value.cast.length,
            itemBuilder: (context, index) {
              return value.cast[index].image != imageCheck
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CastDetailScreen(
                              id: value.cast[index].id,
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
                                  value.cast[index].image,
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
                                value.cast[index].name,
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
      },
    );
  }
}
