import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/models/notification_model.dart';
import 'package:movie_app/core/utils/database_methods.dart';
import 'package:movie_app/core/utils/notification_database_methods.dart';
import 'package:movie_app/core/utils/notify_service.dart';
import 'package:movie_app/data/fetch_home_screen_data.dart';
import 'package:movie_app/view/movie_detail_screen.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _helpController = TextEditingController();
  bool isVisible = false;
  var _movie = [];
  var _movieDb = [];
  bool isLoading = false;
  late DatabaseMethods _databaseMethods;
  late NotificationDatabaseMethods _notificationDatabaseMethods;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    _nameController.text = 'Jessica Liu';
    _usernameController.text = '@Jeje_liu';
    _helpController.text = 'Report a problem';
    _bioController.text = 'Genius, Billionare, Playgirl';
    getDetails();
    getDatabase();
  }

  void getDetails() async {
    var data = await FetchHomeRepo().getHomePageMovies();
    if (data.isNotEmpty) {
      _movie = data[2];
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

  void getDatabase() async {
    _databaseMethods = DatabaseMethods();
    _notificationDatabaseMethods = NotificationDatabaseMethods();
    await _databaseMethods.database;
    await _notificationDatabaseMethods.notifyDatabase;
    _movieDb = await _databaseMethods.getMovieList();
    // print(_movieDb.length);
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _helpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFFF5F6F7),
              child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              right: 20,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.settings),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: SingleChildScrollView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: const Icon(
                                                      Icons.horizontal_rule,
                                                      size: 35,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Settings',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFF35405A),
                                                      fontFamily: 'SF_Pro',
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1.2,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ).copyWith(
                                                  bottom: 20,
                                                ),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.79,
                                                // color: Colors.yellow,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: const [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                              'assets/images/profile.jpg',
                                                            ),
                                                            radius: 47,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 40,
                                                              left: 80,
                                                            ),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFF5F6F7),
                                                              radius: 15,
                                                              child: Icon(
                                                                Icons
                                                                    .camera_alt,
                                                                color: Colors
                                                                    .black,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    labelText('Name'),
                                                    textField(
                                                      hintText:
                                                          'Enter your name',
                                                      controller:
                                                          _nameController,
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    labelText('Username'),
                                                    textField(
                                                      hintText:
                                                          'Enter your username',
                                                      controller:
                                                          _usernameController,
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    labelText('Bio'),
                                                    textField(
                                                      hintText:
                                                          'Enter your bio',
                                                      controller:
                                                          _bioController,
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    labelText('Gender'),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 7,
                                                            horizontal: 20,
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 20,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            // color: Colors.blue,

                                                            border: Border.all(
                                                              width: 0.5,
                                                              // color: Colors.blue,
                                                              color: const Color(
                                                                  0xFF979797),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            'Male',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF616161),
                                                              fontFamily:
                                                                  'SF_Pro',
                                                              // color: Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 7,
                                                            horizontal: 20,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors.blue,
                                                            border: Border.all(
                                                              width: 0.5,
                                                              // color: const Color(0xFF979797),
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            'Female',
                                                            style: TextStyle(
                                                              // color: Color(0xFF616161),
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'SF_Pro',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    labelText('Help'),
                                                    textField(
                                                      isSuffix: true,
                                                      controller:
                                                          _helpController,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        color: const Color(
                                                            0xFF979797),
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                        top: 30,
                                                        bottom: 20,
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 12,
                                                      ),
                                                      child: const Text(
                                                        'Update',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xFF212121),
                                                          fontFamily: 'SF_Pro',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.09,
                            ),
                            child: const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/profile.jpg',
                              ),
                              radius: 47,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.07),
                            child: BlurryContainer(
                              borderRadius: BorderRadius.circular(10),
                              height: MediaQuery.of(context).size.height * 0.19,
                              width: MediaQuery.of(context).size.width * 0.37,
                              child: Container(
                                color: const Color(0x80F5F6F7),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.06,
                            ),
                            child: const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/profile.jpg',
                              ),
                              radius: 40,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2,
                              bottom: MediaQuery.of(context).size.height * 0.16,
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                'assets/images/verify.png',
                              ),
                              radius: 15,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.23,
                            ),
                            child: Column(
                              children: const [
                                Text(
                                  'Jessica Liu',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    '@Jeje_liu',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFB2B6C0),
                                      fontFamily: 'SF_Pro',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/rank.png'),
                        makeDesign(3, 'Want'),
                        makeDesign(2, 'Watched'),
                        makeDesign(8, 'Series'),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ).copyWith(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.485,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 15,
                              ),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF3544C4),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Want',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 15,
                              ),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFFF5F6F7),
                                  ),
                                  foregroundColor: MaterialStatePropertyAll(
                                    Color(0xFF616161),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Watched',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 15,
                              ),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFFF5F6F7),
                                  ),
                                  foregroundColor: MaterialStatePropertyAll(
                                    Color(0xFF616161),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Series',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF_Pro',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _movie.length,
                            itemBuilder: (context, index) {
                              // bool fav=false;
                              return GestureDetector(
                                onTap: () {
                                  // print('Clicked $index');
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                        // id: _movie[index].id,
                                        movieModel: _movie[index],
                                      ),
                                    ),
                                    (Route<dynamic> route) => true,
                                  );
                                },
                                child: Container(
                                  width: 130,
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      // image: AssetImage(
                                      //   'assets/images/poster.png',
                                      // ),
                                      image: NetworkImage(
                                        _movie[index].poster,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  /*child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          left: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BlurryContainer(
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
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      left: 5,
                                                    ),
                                                    child: Text(
                                                      // '7.2',
                                                      _movie[index].voteAverage.toStringAsFixed(1),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: BlurryContainer(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 2,
                                                  horizontal: 7,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.favorite_border,
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
                                  ),*/
                                  child: Container(
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
                                          onTap: () async {
                                            if (_movie[index].favorite == 0) {
                                              // print(_movie[0][index].favorite==1);
                                              if (!isPresent(
                                                  _movie[index].id)) {
                                                _movie[index].favorite = 1;

                                                int id =
                                                    const Uuid().v1().hashCode;

                                                NotificationModel notifyModel =
                                                    NotificationModel(
                                                  id: '$id',
                                                  title: 'Favorite Movie',
                                                  body:
                                                      '${_movie[index].title} added to the Favorite Screen',
                                                  payload:
                                                      'https://my-movie-1432.web.app?id=${_movie[index].id}*$id',
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
                                                // Insert favorite movie to the db
                                                int n = await _databaseMethods
                                                    .insertMovie(_movie[index]);
                                                print(n);
                                                _movieDb =
                                                    await _databaseMethods
                                                        .getMovieList();
                                              }
                                              setState(() {
                                                _movie[index].favorite = 1;
                                              });
                                            } else {
                                              if (isPresent(_movie[index].id)) {
                                                _movie[index].favorite = 0;
                                                // Delete favorite movie from the db
                                                await _databaseMethods
                                                    .deleteMovie(
                                                        _movie[index].id);
                                                _movieDb =
                                                    await _databaseMethods
                                                        .getMovieList();
                                              }
                                              setState(() {
                                                _movie[index].favorite = 0;
                                              });
                                            }
                                          },
                                          child: _movie[index].favorite == 1
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget makeDesign(int size, String name) {
    return Column(
      children: [
        Text(
          '0$size',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF35405A),
            fontFamily: 'SF_Pro',
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey[500],
            fontFamily: 'SF_Pro',
          ),
        ),
      ],
    );
  }

  Widget labelText(String name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Colors.grey[500],
        fontFamily: 'SF_Pro',
      ),
    );
  }

  Widget textField({
    bool isSuffix = false,
    String hintText = '',
    required TextEditingController controller,
  }) {
    return SizedBox(
      height: 35,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          // controller.text = value;
        },
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xFF353535),
          fontFamily: 'SF_Pro',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.grey[500],
            fontFamily: 'SF_Pro',
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.2,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
            ),
          ),
          suffixIcon: isSuffix
              ? const Icon(
                  Icons.arrow_forward_ios,
                )
              : const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.transparent,
                ),
        ),
      ),
    );
  }
}
