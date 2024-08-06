import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/data/fetch_home_screen_data.dart';
import 'package:movie_app/data/fetch_movie_data_by_id.dart';
import 'package:movie_app/models/notification_model.dart';
import 'package:movie_app/resource/cast_list.dart';
import 'package:movie_app/resource/movie_list.dart';
import 'package:movie_app/screens/cast_detail_screen.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/utils/database_methods.dart';
import 'package:movie_app/utils/notification_database_methods.dart';
import 'package:movie_app/utils/notify_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../shimmer/utils/designs.dart';

class MovieDashboard extends StatefulWidget {
  const MovieDashboard({Key? key}) : super(key: key);

  @override
  State<MovieDashboard> createState() => _MovieDashboardState();
}

class _MovieDashboardState extends State<MovieDashboard> {
  bool isLoading = false;
  var _movie = [];
  var _cast = [];
  var _movieDb = [];
  var _scrollMovies = [];
  late DatabaseMethods _databaseMethods;
  late NotificationDatabaseMethods _notificationDatabaseMethods;
  // late Database _database;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    getDetails();
    getDatabase();
  }

  void getDatabase() async {
    _databaseMethods = DatabaseMethods();
    _notificationDatabaseMethods = NotificationDatabaseMethods();
    Database database = await _databaseMethods.database;
    Database notifyDatabase = await _notificationDatabaseMethods.notifyDatabase;
    if (database != null && notifyDatabase != null) {
      _movieDb = await _databaseMethods.getMovieList();
      print('favorite : ${_movieDb.length}');
      var result = await _notificationDatabaseMethods.getNotifyCount();
      print('notification : $result');
    }
  }

  bool isPresent(String id) {
    for (int i = 0; i < _movieDb.length; i++) {
      if (_movieDb[i].id == id) {
        return true;
      }
    }
    return false;
  }

  void getDetails() async {
    _movie = await FetchHomeRepo().getHomePageMovies();
    var data = await FetchMovieDataById().getDetails('10757');

    // if (_movie.isNotEmpty && data.isNotEmpty) {
    if (_movie.isNotEmpty) {
      // print(details[0][0].title);
      // _cast.addAll(data1[2]);
      _cast.addAll(data[2]);
      _cast.shuffle();
      for (int i = 0; i < _movieDb.length; i++) {
        for (int j = 0; j < _movie[0].length; j++) {
          if (_movieDb[i].id == _movie[0][j].id) {
            _movie[0][j].favorite = 1;
            break;
          }
        }
      }
      for (int i = 0; i < _movieDb.length; i++) {
        for (int j = 0; j < _movie[3].length; j++) {
          if (_movieDb[i].id == _movie[3][j].id) {
            _movie[3][j].favorite = 1;
            break;
          }
        }
      }

      _scrollMovies.add(_movie[1][0]);
      _scrollMovies.add(_movie[1][2]);
      _scrollMovies.add(_movie[1][1]);
      _scrollMovies.add(_movie[1][4]);
      _scrollMovies.add(_movie[1][3]);
      _scrollMovies.add(_movie[1][6]);
      _scrollMovies.add(_movie[1][7]);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            // isLoading
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //           color: Colors.blue,
            //         ),
            //       )
            //     :
            Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(213, 213, 213, 1.0),
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ).copyWith(bottom: 0),
          child: Column(
            children: [
              // const SizedBox(
              //   height: 5,
              // ),
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
              Flexible(
                child: ListView(
                  children: [
                    isLoading
                        ? Shimmer.fromColors(
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
                          )
                        : CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.25,
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                            ),
                            items: _scrollMovies
                                .map((movie) => GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                              movieModel: movie,
                                            ),
                                          ),
                                          (Route<dynamic> route) => true,
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            boxShadow: kElevationToShadow[8],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl: movie.backdrop,
                                                  width: double.infinity,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .38) *
                                                          .6,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
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
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(
                                                    movie.title,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                          ),
                    const SizedBox(
                      height: 5,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 6,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MovieLists(
                                  title: 'Movies',
                                  // size: 30,
                                  isSearchBar: true,
                                  isFavorite: false,
                                ),
                              ),
                              (Route<dynamic> route) => true,
                            );
                          },
                          child: const Text(
                            'See more',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF_Pro',
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// Popular Movies Poster and Details
                    isLoading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: SizedBox(
                              height: 220,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                    posterPlaceholder(height: 220, width: 165),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _movie[0].length,
                              itemBuilder: (context, index) {
                                // bool fav=false;
                                return GestureDetector(
                                  onTap: () {
                                    // print('Clicked $index');
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(
                                          // id: _movie[0][index].id,
                                          movieModel: _movie[0][index],
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
                                        // image: AssetImage(
                                        //   'assets/images/person.webp',
                                        // ),
                                        image: NetworkImage(
                                            _movie[0][index].poster),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BlurryContainer(
                                                blur: 1,
                                                color: Colors.black38,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 2,
                                                  horizontal: 7,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFFC31A),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 5,
                                                      ),
                                                      child: Text(
                                                        // '7.2',
                                                        '${_movie[0][index].voteAverage.toStringAsFixed(1)}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'SF_Pro',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: BlurryContainer(
                                                  blur: 1,
                                                  color: Colors.black38,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 4,
                                                    horizontal: 10,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (_movie[0][index]
                                                              .favorite ==
                                                          0) {
                                                        // print(_movie[0][index].favorite==1);
                                                        if (!isPresent(_movie[0]
                                                                [index]
                                                            .id)) {
                                                          _movie[0][index]
                                                              .favorite = 1;

                                                          int id = const Uuid()
                                                              .v1()
                                                              .hashCode;

                                                          NotificationModel
                                                              notifyModel =
                                                              NotificationModel(
                                                            // id: '${Random().nextInt(9000000)}',
                                                            id: '$id',
                                                            title:
                                                                'Favorite Movie',
                                                            body:
                                                                '${_movie[0][index].title} added to the Favorite Screen',
                                                            payload:
                                                                'https://my-movie-1432.web.app?id=${_movie[0][index].id}*$id',
                                                            date: DateFormat
                                                                    .yMd()
                                                                .add_jm()
                                                                .format(DateTime
                                                                    .now()),
                                                          );

                                                          NotificationService()
                                                              .showNotification(
                                                            // id: int.parse(
                                                            //     notifyModel.id),
                                                            id: notifyModel
                                                                .id.hashCode,
                                                            title: notifyModel
                                                                .title,
                                                            body: notifyModel
                                                                .body,
                                                            // payload: notifyModel
                                                            //     .payload,
                                                            payload: notifyModel
                                                                .payload,
                                                          );

                                                          await _notificationDatabaseMethods
                                                              .insertNotify(
                                                                  notifyModel);

                                                          // Insert favorite movie to the db
                                                          int n =
                                                              await _databaseMethods
                                                                  .insertMovie(
                                                                      _movie[0][
                                                                          index]);
                                                          print(n);
                                                          _movieDb =
                                                              await _databaseMethods
                                                                  .getMovieList();
                                                        }
                                                        setState(() {
                                                          _movie[0][index]
                                                              .favorite = 1;
                                                        });
                                                      } else {
                                                        if (isPresent(_movie[0]
                                                                [index]
                                                            .id)) {
                                                          _movie[0][index]
                                                              .favorite = 0;
                                                          // Delete favorite movie from the db
                                                          await _databaseMethods
                                                              .deleteMovie(
                                                                  _movie[0][
                                                                          index]
                                                                      .id);
                                                          _movieDb =
                                                              await _databaseMethods
                                                                  .getMovieList();
                                                        }
                                                        setState(() {
                                                          _movie[0][index]
                                                              .favorite = 0;
                                                        });
                                                      }
                                                    },
                                                    child: _movie[0][index]
                                                                .favorite ==
                                                            1
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                            size: 20,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.white,
                                                            size: 20,
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
                                );
                              },
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Actor\'s',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SF_Pro',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CastLists(
                                  title: 'Casts',
                                ),
                              ),
                              (Route<dynamic> route) => true,
                            );
                          },
                          child: const Text(
                            'See more',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF_Pro',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// Cast Poster and Details
                    isLoading
                        ? Shimmer.fromColors(
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
                                  margin: const EdgeInsets.only(top: 10,),
                                  height: 20,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
                                    itemBuilder: (context, index) =>
                                        textPlaceholder(width: 80),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _cast.length,
                              itemBuilder: (context, index) {
                                return _cast[index].image != imageCheck
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CastDetailScreen(
                                                // id: '225730',
                                                id: _cast[index].id,
                                                isHome: true,
                                              ),
                                            ),
                                            (Route<dynamic> route) => true,
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 80,
                                              margin: const EdgeInsets.only(
                                                  right: 20),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  // image: AssetImage(
                                                  //   'assets/images/bg.jpeg',
                                                  // ),
                                                  image: NetworkImage(
                                                    _cast[index].image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                child: Text(
                                                  // 'Marlon Brando',
                                                  _cast[index].name,
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
                          ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 15,
                        left: 5,
                      ),
                      child: Text(
                        'Upcoming Movies',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF_Pro',
                        ),
                      ),
                    ),
                    isLoading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: SizedBox(
                              height: 220,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                    posterPlaceholder(height: 220, width: 165),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _movie[3].length,
                              itemBuilder: (context, index) {
                                // bool fav=false;
                                return GestureDetector(
                                  onTap: () {
                                    // print('Clicked $index');
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(
                                          // id: _movie[0][index].id,
                                          movieModel: _movie[3][index],
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
                                        // image: AssetImage(
                                        //   'assets/images/person.webp',
                                        // ),
                                        image: NetworkImage(
                                            _movie[3][index].poster),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BlurryContainer(
                                                blur: 1,
                                                color: Colors.black38,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 2,
                                                  horizontal: 7,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFFC31A),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 5,
                                                      ),
                                                      child: Text(
                                                        // '7.2',
                                                        '${_movie[3][index].voteAverage.toStringAsFixed(1)}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'SF_Pro',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: BlurryContainer(
                                                  blur: 1,
                                                  color: Colors.black38,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 4,
                                                    horizontal: 10,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (_movie[3][index]
                                                              .favorite ==
                                                          0) {
                                                        // print(_movie[0][index].favorite==1);
                                                        if (!isPresent(_movie[3]
                                                                [index]
                                                            .id)) {
                                                          _movie[3][index]
                                                              .favorite = 1;

                                                          int id = const Uuid()
                                                              .v1()
                                                              .hashCode;

                                                          NotificationModel
                                                              notifyModel =
                                                              NotificationModel(
                                                            id: '$id',
                                                            title:
                                                                'Favorite Movie',
                                                            body:
                                                                '${_movie[3][index].title} added to the Favorite Screen',
                                                            payload:
                                                                'https://my-movie-1432.web.app?id=${_movie[3][index].id}*$id',
                                                            date: DateFormat
                                                                    .yMd()
                                                                .add_jm()
                                                                .format(DateTime
                                                                    .now()),
                                                          );

                                                          NotificationService()
                                                              .showNotification(
                                                            id: int.parse(
                                                                notifyModel.id),
                                                            title: notifyModel
                                                                .title,
                                                            body: notifyModel
                                                                .body,
                                                            // payload: notifyModel
                                                            //     .payload,
                                                            payload: notifyModel
                                                                .payload,
                                                          );

                                                          await _notificationDatabaseMethods
                                                              .insertNotify(
                                                                  notifyModel);
                                                          // Insert favorite movie to the db
                                                          int n =
                                                              await _databaseMethods
                                                                  .insertMovie(
                                                                      _movie[3][
                                                                          index]);
                                                          print(n);
                                                          _movieDb =
                                                              await _databaseMethods
                                                                  .getMovieList();
                                                        }
                                                        setState(() {
                                                          _movie[3][index]
                                                              .favorite = 1;
                                                        });
                                                      } else {
                                                        if (isPresent(_movie[3]
                                                                [index]
                                                            .id)) {
                                                          _movie[3][index]
                                                              .favorite = 0;
                                                          // Delete favorite movie from the db
                                                          await _databaseMethods
                                                              .deleteMovie(
                                                                  _movie[3][
                                                                          index]
                                                                      .id);
                                                          _movieDb =
                                                              await _databaseMethods
                                                                  .getMovieList();
                                                        }
                                                        setState(() {
                                                          _movie[3][index]
                                                              .favorite = 0;
                                                        });
                                                      }
                                                    },
                                                    child: _movie[3][index]
                                                                .favorite ==
                                                            1
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                            size: 20,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.white,
                                                            size: 20,
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
                                );
                              },
                            ),
                          ),
                    const SizedBox(
                      height: 63,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
