import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/data/cast_details.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({Key? key}) : super(key: key);

  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  // List items = [1, 2, 3, 4, 5, 6, 7, 8];
  final _scrollController = FixedExtentScrollController();
  late List<MovieModel> _movies;

  @override
  void initState() {
    super.initState();
    _movies = CastData.movies;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 90,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.72,
          width: MediaQuery.of(context).size.width * 0.8,
          /*child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 15,),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10,),
                height: MediaQuery.of(context).size.height*0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: 115,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/poster.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 15, left: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 10),
                                  child: BlurryContainer(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 7,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        // ):const Icon(Icons.favorite,color: Colors.white,
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
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Avatar 2 : Underground',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Color(0xFFFFE371),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Color(0xFFFFE371),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Color(0xFFFFE371),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Color(0xFFFFE371),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Color(0xFFE5E5E5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '4.5',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF979797),
                                  width: 0.7,
                                ),
                                borderRadius:
                                BorderRadius.circular(3)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            child: const Text(
                              'Horror',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF616161),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.access_time_filled,
                                  color: Color(0xFFD6D6D6),
                                  size: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    '2h 37m',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),*/
          ///comments
          /*child: ListWheelScrollView(
            itemExtent: 200,
            // children: items
            children: _movies
                .map((value) => Container(
                      margin: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: 115,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    // image: AssetImage(
                                    //   'assets/images/poster.png',
                                    // ),
                                    image: NetworkImage(
                                      value.poster,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 115,
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  top: 10,
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: BlurryContainer(
                                    blur: 1,
                                    color: Colors.white54,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 7,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 18,
                                        // ):const Icon(Icons.favorite,color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // 'Avatar 2 : Underground',
                                  value.title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Color(0xFFFFE371),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Color(0xFFFFE371),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Color(0xFFFFE371),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Color(0xFFFFE371),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Color(0xFFE5E5E5),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          // '4.5',
                                          value.voteAverage.toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF979797),
                                        width: 0.7,
                                      ),
                                      borderRadius: BorderRadius.circular(3)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 8),
                                  child: Text(
                                    // 'Horror',
                                    value.genres.isNotEmpty
                                        ? getGenre(value.genres[0])
                                        : 'No Genre',
                                    // getGenre(value.genres[0]),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF616161),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.access_time_filled,
                                        color: Color(0xFFD6D6D6),
                                        size: 16,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          '2h 37m',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),*/
          child: ClickableListWheelScrollView(
            scrollController: _scrollController,
            itemHeight: MediaQuery.of(context).size.height * 0.29,
            itemCount: _movies.length,
            onItemTapCallback: (index) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(
                    // id: _movies[index].id,
                    movieModel: _movies[index],
                  ),
                ),
                (Route<dynamic> route) => true,
              );
            },
            child: ListWheelScrollView.useDelegate(
              controller: _scrollController,
              itemExtent: MediaQuery.of(context).size.height * 0.28,
              useMagnifier: true,
              physics: const FixedExtentScrollPhysics(),
              overAndUnderCenterOpacity: 0.5,
              perspective: 0.002,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: _movies.length,
                builder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      // id: _movies[index].id,
                                      movieModel: _movies[index],
                                    ),
                                  ),
                                  (Route<dynamic> route) => true,
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: 115,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    // image: AssetImage(
                                    //   'assets/images/poster.png',
                                    // ),
                                    image: NetworkImage(
                                      _movies[index].poster,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 115,
                              padding: const EdgeInsets.only(
                                right: 10,
                                top: 10,
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: BlurryContainer(
                                  blur: 1,
                                  color: Colors.black38,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 7,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 18,
                                      // ):const Icon(Icons.favorite,color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // 'Avatar 2 : Underground',
                                _movies[index].title,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SF_Pro',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Color(0xFFFFE371),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Color(0xFFFFE371),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Color(0xFFFFE371),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Color(0xFFFFE371),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Color(0xFFE5E5E5),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Text(
                                        // '4.5',
                                        _movies[index]
                                            .voteAverage
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SF_Pro',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF979797),
                                      width: 0.7,
                                    ),
                                    borderRadius: BorderRadius.circular(3)),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 8,
                                ),
                                child: Text(
                                  // 'Horror',
                                  _movies[index].genres.isNotEmpty
                                      ? getGenre(_movies[index].genres[0])
                                      : 'No Genre',
                                  // getGenre(value.genres[0]),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF616161),
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled,
                                      color: Color(0xFFD6D6D6),
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: Text(
                                        // '2h 37m',
                                        getYear(_movies[index].releaseDate),
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SF_Pro',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
