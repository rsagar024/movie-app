import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/models/notification_model.dart';
import 'package:movie_app/core/utils/database_methods.dart';
import 'package:movie_app/core/utils/notification_database_methods.dart';
import 'package:movie_app/core/utils/notify_service.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/data/fetch_home_screen_data.dart';
import 'package:movie_app/view/movie_detail_screen.dart';
import 'package:uuid/uuid.dart';

class MovieLists extends StatefulWidget {
  final String title;
  // final int size;
  final bool isGenres;
  final bool isSearchBar;
  final bool isFavorite;
  const MovieLists({
    Key? key,
    required this.title,
    // required this.size,
    this.isGenres = false,
    this.isSearchBar = false,
    this.isFavorite = true,
  }) : super(key: key);

  @override
  State<MovieLists> createState() => _MovieListsState();
}

class _MovieListsState extends State<MovieLists> {
  bool isLoading = false;
  List _movie = [];
  List _movieDb = [];
  late DatabaseMethods _databaseMethods;
  late NotificationDatabaseMethods _notificationDatabaseMethods;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    getDatabase();
    widget.isFavorite ? loadMovies() : getDetails();
    // getDatabase();
    // getDetails();
  }

  void getDatabase() async {
    _databaseMethods = DatabaseMethods();
    _notificationDatabaseMethods = NotificationDatabaseMethods();
    await _databaseMethods.database;
    await _notificationDatabaseMethods.notifyDatabase;
    _movieDb = await _databaseMethods.getMovieList();
  }

  void loadMovies() async {
    _movie = await _databaseMethods.getMovieList();
    _movieDb = _movie;
    setState(() {
      isLoading = false;
    });
  }

  Future refresh() async {
    setState(() {
      _movie.clear();
      isLoading = true;
    });
    getDatabase();
    widget.isFavorite ? loadMovies() : getDetails();
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
    var data = await FetchHomeRepo().getHomePageMovies();
    if (data.isNotEmpty) {
      // print(details[0][0].title);
      _movie.addAll(data[0]);
      _movie.addAll(data[1]);
      _movie.addAll(data[2]);
      // print(_movie[0].runtimeType);
      _movie.shuffle();
      for (int i = 0; i < _movieDb.length; i++) {
        for (int j = 0; j < _movie.length; j++) {
          if (_movieDb[i].id == _movie[j].id) {
            _movie[j].favorite = 1;
            break;
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(213, 213, 213, 1.0),
                        Colors.white,
                        Colors.white,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            widget.isFavorite
                                ? Container()
                                : IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                      Icons.arrow_back,
                                    ),
                                  ),
                            Flexible(
                              flex: widget.isFavorite ? 3 : 2,
                              child: Container(),
                            ),
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 23,
                                color: Color(0xFF272F4B),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SF_Pro',
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                        ),
                        child: Text(
                          'Showing ${_movie.length} Results',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF616161),
                            fontFamily: 'SF_Pro',
                          ),
                        ),
                      ),

                      /// Genre Options
                      widget.isGenres
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          Color(0xFF3544C4),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'All',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'SF_Pro',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          Colors.white,
                                        ),
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                          Colors.black,
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Action',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'SF_Pro',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          Colors.white,
                                        ),
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                          Colors.black,
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Adventure',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'SF_Pro',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),

                      /// Search Bar
                      widget.isSearchBar
                          ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.arrow_back,
                                      color: Color(0xFF1C2238),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      color: Color(0xFF1C2238),
                                    ),
                                    labelText: 'Movies',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'SF_Pro',
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Color(0xFF272F4B),
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                              ),
                            )
                          : Container(),

                      /// Movies Details
                      Flexible(
                        child: RefreshIndicator(
                          onRefresh: refresh,
                          child: ListView.builder(
                            itemCount: _movie.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFDEE2EE),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    ///Scrolling Movie Posters
                                    Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailScreen(
                                                  // id: _movie[index].id,
                                                  movieModel: _movie[index],
                                                ),
                                              ),
                                              (Route<dynamic> route) => true,
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            height: 140,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                // image: AssetImage(
                                                //   'assets/images/home.webp',
                                                // ),
                                                image: NetworkImage(
                                                  _movie[index].poster,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 10,
                                          ),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: BlurryContainer(
                                              blur: 1,
                                              color: Colors.black38,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 8,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (_movie[index].favorite ==
                                                      0) {
                                                    // print(_movie[0][index].favorite==1);
                                                    if (!isPresent(
                                                        _movie[index].id)) {
                                                      _movie[index].favorite =
                                                          1;

                                                      int id = const Uuid()
                                                          .v1()
                                                          .hashCode;

                                                      NotificationModel
                                                          notifyModel =
                                                          NotificationModel(
                                                        id: '$id',
                                                        title: 'Favorite Movie',
                                                        body:
                                                            '${_movie[index].title} added to the Favorite Screen',
                                                        payload:
                                                            'https://my-movie-1432.web.app?id=${_movie[index].id}*$id',
                                                        date: DateFormat.yMd()
                                                            .add_jm()
                                                            .format(
                                                                DateTime.now()),
                                                      );

                                                      NotificationService()
                                                          .showNotification(
                                                        id: int.parse(
                                                            notifyModel.id),
                                                        title:
                                                            notifyModel.title,
                                                        body: notifyModel.body,
                                                        payload:
                                                            notifyModel.payload,
                                                      );

                                                      await _notificationDatabaseMethods
                                                          .insertNotify(
                                                              notifyModel);
                                                      // Insert favorite movie to the db
                                                      int n =
                                                          await _databaseMethods
                                                              .insertMovie(
                                                                  _movie[
                                                                      index]);
                                                      print(n);
                                                      _movieDb =
                                                          await _databaseMethods
                                                              .getMovieList();
                                                    }
                                                    setState(() {
                                                      _movie[index].favorite =
                                                          1;
                                                    });
                                                  } else {
                                                    if (isPresent(
                                                        _movie[index].id)) {
                                                      _movie[index].favorite =
                                                          0;
                                                      // Delete favorite movie from the db
                                                      await _databaseMethods
                                                          .deleteMovie(
                                                              _movie[index].id);
                                                      _movieDb =
                                                          await _databaseMethods
                                                              .getMovieList();
                                                    }
                                                    setState(() {
                                                      _movie[index].favorite =
                                                          0;
                                                    });
                                                  }
                                                },
                                                child: _movie[index].favorite ==
                                                        1
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                        size: 18,
                                                      )
                                                    : const Icon(
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

                                    ///Scrolling Movie Details
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // 'Avatar 2 : The Way of Water',
                                            '${_movie[index].title}',
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
                                                  size: 18,
                                                  color: Color(0xFFFFE371),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  size: 18,
                                                  color: Color(0xFFFFE371),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  size: 18,
                                                  color: Color(0xFFFFE371),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  size: 18,
                                                  color: Color(0xFFFFE371),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  size: 18,
                                                  color: Color(0xFFE5E5E5),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                  ),
                                                  child: Text(
                                                    // '4.5',
                                                    '${_movie[index].voteAverage.toStringAsFixed(1)}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              // 'Horror',
                                              widget.isFavorite
                                                  ? getGenre(int.parse(
                                                      _movie[index].genres[0]))
                                                  : getGenre(
                                                      _movie[index].genres[0]),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF616161),
                                                fontFamily: 'SF_Pro',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.access_time_filled,
                                                  color: Color(0xFFD6D6D6),
                                                  size: 16,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  child: Text(
                                                    // '2h 37m',
                                                    _movie[index].releaseDate,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                      widget.isFavorite
                          ? const SizedBox(
                              height: 55,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
