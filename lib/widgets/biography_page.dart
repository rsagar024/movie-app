import 'package:flutter/material.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/data/cast_details.dart';
import 'package:readmore/readmore.dart';

class BiographyPage extends StatefulWidget {
  const BiographyPage({Key? key}) : super(key: key);

  @override
  State<BiographyPage> createState() => _BiographyPageState();
}

class _BiographyPageState extends State<BiographyPage> {
  bool isClicked = false;

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
              height: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                children: [
                  Text(
                    '${CastData.castInfo.knownFor} • Film Directors',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                      fontFamily: 'SF_Pro',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      // 'Sindiana Samin',
                      CastData.castInfo.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF35405A),
                        fontFamily: 'SF_Pro',
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
                                padding: EdgeInsets.only(left: 6, right: 3),
                                child: Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF_Pro',
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ReadMoreText(
                      // 'An actress who was born in Japan and has unique advanta an actress who was born in Japan and has unique advanta',
                      shortBio(CastData.castInfo.bio),
                      trimLines: 2,
                      colorClickableText: Colors.green,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      style: const TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w600,
                        color: Color(0xFF35405A),
                        fontFamily: 'SF_Pro',
                      ),
                      moreStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3544C4),
                        fontFamily: 'SF_Pro',
                      ),
                      lessStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3544C4),
                        fontFamily: 'SF_Pro',
                      ),
                    ),
                  ),
                  /*Padding(
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
                  ),*/
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
      ),
    );
  }
}
