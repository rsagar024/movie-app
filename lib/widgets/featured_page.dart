import 'package:flutter/material.dart';
import 'package:movie_app/data/cast_details.dart';
import 'package:movie_app/models/movie_model.dart';

class FeaturedPage extends StatefulWidget {
  const FeaturedPage({Key? key}) : super(key: key);

  @override
  State<FeaturedPage> createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {
  late List<MovieModel> _movies;

  @override
  void initState() {
    super.initState();
    _movies = CastData.movies;
    _movies.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.52,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'All best featured films',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                        fontFamily: 'SF_Pro',
                      ),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: ListView.separated(
                      itemCount: _movies.length ~/ 2 > 15
                          ? _movies.length ~/ 4
                          : _movies.length ~/ 2,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xFFDEE2EE),
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF35405A),
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: MediaQuery.of(context).size.width * 0.5,
                                /*child: Column(
                                  children: [
                                    Text(
                                      // 'Gangs of New York',
                                      _movies[index].title,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Text(
                                        'Martin Scorsese',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF939393),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                                child: Text(
                                  // 'Gangs of New York',
                                  _movies[index].title,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF333333),
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFDEE2EE),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Color(0xFF3544C4),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
