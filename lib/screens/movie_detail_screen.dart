import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/data/fetch_movie_data_by_id.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/notification_model.dart';
import 'package:movie_app/screens/cast_detail_screen.dart';
import 'package:movie_app/utils/database_methods.dart';
import 'package:movie_app/utils/notification_database_methods.dart';
import 'package:movie_app/utils/notify_service.dart';
import 'package:readmore/readmore.dart';
import 'package:uuid/uuid.dart';

class MovieDetailScreen extends StatefulWidget {
  // final String id;
  final MovieModel movieModel;
  const MovieDetailScreen({
    Key? key,
    // required this.id,
    required this.movieModel,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isLoading = false;
  var _details = [];
  bool isFavorite = false;
  bool isClicked = false;
  late MovieModel _movieData;
  List _movieDb = [];
  late DatabaseMethods _databaseMethods;
  late NotificationDatabaseMethods _notificationDatabaseMethods;
  // List<String> genres = [
  //   'ACTION',
  //   'ADVENTURE',
  //   'FANTASY',
  // ];
  List<String> key = ['Length', 'Language', 'Rating'];
  List<String> value = [];
  // ['2h 28min', 'English', 'PG-13'];

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    getDatabase();
    getDetails(widget.movieModel.id);
    _movieData = widget.movieModel;
    // print(_movieData.id);
    // print(763215.toString());
  }

  void getDetails(String id) async {
    var data = await FetchMovieDataById().getDetails(id);
    if (data.isNotEmpty) {
      _details = data;
      // print(_details[3].runtime);
      // value.add(_details[3].runtime);
      value.add(getDuration(_details[3].runtime));
      value.add('${_details[3].language}');
      value.add('${_details[3].rated}');

      setState(() {
        isLoading = false;
      });
      // print(_details[0].genres[0]);
    } else {
      throw Exception('Error');
    }
  }

  void getDatabase() async {
    _databaseMethods = DatabaseMethods();
    _notificationDatabaseMethods = NotificationDatabaseMethods();
    await _databaseMethods.database;
    await _notificationDatabaseMethods.notifyDatabase;
    _movieDb = await _databaseMethods.getMovieList();
  }

  bool isPresent(String id) {
    for (int i = 0; i < _movieDb.length; i++) {
      if (_movieDb[i].id == id) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    try {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            // image: AssetImage(
                            //   'assets/images/bg.jpeg',
                            // ),
                            image: NetworkImage('${_details[1][0].image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListView(
                        children: [
                          Container(
                            // height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ).copyWith(bottom: 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        // 'Avatar 2 : The most Underground',
                                        '${_details[0].title}',
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SF_Pro',
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (_movieData.favorite == 0) {
                                              _movieData.favorite = 1;
                                              /*NotificationService().showNotification(
                                                  id: Random().nextInt(123456),
                                                  title: 'Favorite Movie',
                                                  body: '${_movieData.title} added to the Favorite Screen'
                                              );*/

                                              int id =
                                                  const Uuid().v1().hashCode;

                                              NotificationModel notifyModel =
                                                  NotificationModel(
                                                id: '$id',
                                                title: 'Favorite Movie',
                                                body:
                                                    '${_movieData.title} added to the Favorite Screen',
                                                payload:
                                                    'https://my-movie-1432.web.app?id=${_movieData.id}*$id',
                                                date: DateFormat.yMd()
                                                    .add_jm()
                                                    .format(DateTime.now()),
                                              );

                                              NotificationService()
                                                  .showNotification(
                                                id: int.parse(notifyModel.id),
                                                title: notifyModel.title,
                                                body: notifyModel.body,
                                                payload: notifyModel.payload,
                                              );

                                              await _notificationDatabaseMethods
                                                  .insertNotify(notifyModel);

                                              await _databaseMethods
                                                  .insertMovie(_movieData);
                                              _movieDb = await _databaseMethods
                                                  .getMovieList();
                                              setState(() {
                                                _movieData.favorite = 1;
                                              });
                                            } else {
                                              _movieData.favorite = 0;
                                              await _databaseMethods
                                                  .deleteMovie(_movieData.id);
                                              _movieDb = await _databaseMethods
                                                  .getMovieList();
                                              setState(() {
                                                _movieData.favorite = 0;
                                              });
                                            }
                                          },
                                          child: _movieData.favorite == 1
                                              ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.favorite_border,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                        ),
                                        child: Text(
                                          // '9.1/10 IMDb',
                                          '${_details[0].rating.toStringAsFixed(1)}/10 IMDb',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF919191),
                                            fontFamily: 'SF_Pro',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: SizedBox(
                                    height: 22,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _details[0].genres.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color(0xFFDCE3FF),
                                          ),
                                          child: Center(
                                            child: Text(
                                              // genres[index],
                                              getGenre(_details[0].genres[index]
                                                  ['id']),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF90A9EA),
                                                fontFamily: 'SF_Pro',
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: SizedBox(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width,
                                    // width: double.infinity,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: key.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  key[index],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF919191),
                                                    fontFamily: 'SF_Pro',
                                                  ),
                                                ),
                                                Text(
                                                  value[index],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'SF_Pro',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    /*child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        for (int index = 0;
                                            index < key.length;
                                            index++)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                key[index],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF919191),
                                                ),
                                              ),
                                              Text(
                                                value[index],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),*/
                                  ),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SF_Pro',
                                    ),
                                  ),
                                ),
                                /*isClicked
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isClicked = false;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional.centerStart,
                                            child: Text(
                                              // 'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
                                              '${_details[0].overview}',
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            // 'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
                                            '${_details[0].overview}',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                isClicked
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isClicked = true;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Read more',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF3544C4),
                                              ),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xFF3544C4),
                                            )
                                          ],
                                        ),
                                      ),*/
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: ReadMoreText(
                                    '${_details[0].overview}',
                                    trimLines: 3,
                                    colorClickableText: Colors.green,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: ' Show more',
                                    trimExpandedText: ' Show less',
                                    moreStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3544C4),
                                      fontFamily: 'SF_Pro',
                                    ),
                                    lessStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3544C4),
                                      fontFamily: 'SF_Pro',
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'SF_Pro',
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: const Text(
                                        'Casts',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'SF_Pro',
                                        ),
                                      ),
                                    ),
                                    /* Flexible(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const CastLists(
                                                  title: 'Casts',
                                                  size: 15,
                                                  isHome: false,
                                                ),
                                              ),
                                              (Route<dynamic> route) => true,
                                            );
                                          },
                                          child: const Text(
                                            'See all',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),*/
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: SizedBox(
                                    height: 160,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _details[2].length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // debugPrint(index.toString());
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CastDetailScreen(
                                                  id: _details[2][index].id,
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
                                                  right: 20,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    // image: AssetImage(
                                                    //   'assets/images/bg.jpeg',
                                                    // ),
                                                    image: NetworkImage(
                                                      _details[2][index].image,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 80,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10,
                                                  ),
                                                  child: Text(
                                                    // 'Marlon Brando',
                                                    '${_details[2][index].name}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SF_Pro',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      );
    } catch (e) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/exclamation.png',
                  ),
                  backgroundColor: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 7,
                  ),
                  child: Text(
                    'Something went wrong!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF_Pro',
                    ),
                  ),
                ),
                Text(
                  'We so sorry about the error. Please try again later.',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SF_Pro',
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
