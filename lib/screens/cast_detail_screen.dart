import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/global_variable.dart';
import 'package:movie_app/data/cast_details.dart';
import 'package:movie_app/data/fetch_cast_details.dart';

class CastDetailScreen extends StatefulWidget {
  final String id;
  final bool isHome;
  const CastDetailScreen({Key? key, required this.id, this.isHome = false})
      : super(key: key);

  @override
  State<CastDetailScreen> createState() => _CastDetailScreenState();
}

class _CastDetailScreenState extends State<CastDetailScreen> {
  bool isLoading = false;
  int _page = 0;
  late PageController pageController;
  late List _details;
  // bool isClicked = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    pageController = PageController();
    getDetails(widget.id);
  }

  void getDetails(String id) async {
    var data = await FetchCastInfoById().getCastDetails(id);
    // print(data);
    if (data.isNotEmpty) {
      _details = data;
      CastData.castInfo = data[0];
      CastData.socialMedia = data[1];
      CastData.backdrops = data[2];
      CastData.movies = data[3];

      /*print(CastData.castInfo);
      print(CastData.socialMedia);
      print(CastData.backdrops);
      print(CastData.movies);*/

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
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
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: AssetImage(
                    //   'assets/images/actor.png',
                    // ),
                    image: NetworkImage(
                      '${_details[0].image}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.white12,
                            Colors.white38,
                            Colors.white70,
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                    /*Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListView(
                        children: [
                          Text(
                            'Actors • Film Directors',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Sindiana Samin',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF35405A),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 5,
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 6, right: 3),
                                        child: Text(
                                          '4.5',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Color(0xFFFFE371),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  isClicked
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isClicked = false;
                                            });
                                          },
                                          child: const Text(
                                            'An actress who was born in Japan and has unique advanta an actress who was born in Japan and has unique advanta',
                                            style: TextStyle(
                                              fontSize: 16,
                                              // fontWeight: FontWeight.w600,
                                              color: Color(0xFF35405A),
                                            ),
                                          ),
                                        )
                                      : const Text(
                                          'An actress who was born in Japan and has unique advanta an actress who was born in Japan and has unique advanta',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            // fontWeight: FontWeight.w600,
                                            color: Color(0xFF35405A),
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
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Image(
                                    image: AssetImage(
                                      'assets/images/fb.png',
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage(
                                      'assets/images/insta.png',
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage(
                                      'assets/images/twitter.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
                    PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      onPageChanged: onPageChanged,
                      children: items,
                    ),
                    /*widget.isHome
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DashboardScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CastLists(
                                        title: 'Casts',
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                          ),*/
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(8),
                          elevation: 8,
                          child: Container(
                            // margin: const EdgeInsets.only(bottom: 20),
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => navigationTapped(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: _page == 0
                                          ? const Color(0xFF3544C4)
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    child: _page == 0
                                        ? const Text(
                                            'Biography',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'SF_Pro',
                                            ),
                                          )
                                        : const Text(
                                            'Biography',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'SF_Pro',
                                            ),
                                          ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => navigationTapped(1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: _page == 1
                                          ? const Color(0xFF3544C4)
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    child: _page == 1
                                        ? const Text(
                                            'Featured films',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'SF_Pro',
                                            ),
                                          )
                                        : const Text(
                                            'Featured films',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'SF_Pro',
                                            ),
                                          ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => navigationTapped(2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: _page == 2
                                          ? const Color(0xFF3544C4)
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    child: _page == 2
                                        ? const Text(
                                            'Directory\'s',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'SF_Pro',
                                            ),
                                          )
                                        : const Text(
                                            'Directory\'s',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'SF_Pro',
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
