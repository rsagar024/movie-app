import 'package:flutter/material.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/data/fetch_movie_data_by_id.dart';
import 'package:movie_app/view/cast_detail_screen.dart';

class CastLists extends StatefulWidget {
  final String title;
  final bool isHome;
  const CastLists({Key? key, required this.title, this.isHome = true})
      : super(key: key);

  @override
  State<CastLists> createState() => _CastListsState();
}

class _CastListsState extends State<CastLists> {
  bool isLoading = false;
  var _cast = [];

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    getDetails();
  }

  void getDetails() async {
    var data1 = await FetchMovieDataById().getDetails('8079');
    var data2 = await FetchMovieDataById().getDetails('872585');

    if (data1.isNotEmpty && data2.isNotEmpty) {
      _cast.addAll(data1[2]);
      _cast.addAll(data2[2]);
      _cast.shuffle();
      setState(() {
        isLoading = false;
      });
    }
  }

  Future refresh() async {
    setState(() {
      _cast.clear();
      isLoading = true;
    });
    getDetails();
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
                        height: 25,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            /*widget.isHome
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DashboardScreen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MovieDetailScreen(
                                            id: '763215',
                                          ),
                                        ),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                    ),
                                  ),*/
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 23,
                                color: Color(0xFF272F4B),
                                fontWeight: FontWeight.bold,
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
                          'Showing ${_cast.length} ${widget.title}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF616161),
                            fontFamily: 'SF_Pro',
                          ),
                        ),
                      ),

                      /// Search Bar
                      Align(
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
                                labelText: 'Casts',
                                labelStyle: const TextStyle(
                                  fontFamily: 'SF_Pro',
                                )),
                            style: const TextStyle(
                              color: Color(0xFF272F4B),
                              fontFamily: 'SF_Pro',
                            ),
                          ),
                        ),
                      ),

                      /// Cast Details
                      Flexible(
                        child: RefreshIndicator(
                          onRefresh: refresh,
                          child: ListView.builder(
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
                                              id: _cast[index].id,
                                            ),
                                          ),
                                          (Route<dynamic> route) => true,
                                        );
                                      },
                                      child: Container(
                                        // margin: const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
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
                                        // color: Colors.yellow,
                                        height: 160,
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            ///Scrolling Cast Posters
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 20),
                                              height: 130,
                                              width: 97,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  // image: AssetImage(
                                                  //   'assets/images/home.webp',
                                                  // ),
                                                  image: NetworkImage(
                                                    _cast[index].image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),

                                            ///Scrolling Cast Details
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    // 'Marlon Brando',
                                                    _cast[index].name,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'SF_Pro',
                                                    ),
                                                  ),
                                                  /*Text(
                                                    _cast[index].gender,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'SF_Pro',
                                                    ),
                                                  ),*/
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                      top: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFF979797),
                                                        width: 0.7,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 2,
                                                      horizontal: 8,
                                                    ),
                                                    child: Text(
                                                      // 'Horror',
                                                      _cast[index].gender,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color(0xFF616161),
                                                        fontFamily: 'SF_Pro',
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      _cast[index].department,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'SF_Pro',
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        // '4.5',
                                                        _cast[index]
                                                            .popularity
                                                            .toStringAsFixed(1),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'SF_Pro',
                                                        ),
                                                      ),

                                                      /*Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color:
                                                            Color(0xFFFFE371),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color:
                                                            Color(0xFFFFE371),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color:
                                                            Color(0xFFFFE371),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color:
                                                            Color(0xFFE5E5E5),
                                                      ),*/
                                                      const Padding(
                                                        padding: EdgeInsets.only(
                                                          left: 5,
                                                        ),
                                                        child: Icon(
                                                          Icons.star,
                                                          size: 20,
                                                          color:
                                                              Color(0xFFFFE371),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
