import 'package:flutter/material.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:movie_app/view/cast_detail_screen.dart';
import 'package:movie_app/view_model/movie_details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

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
  @override
  void initState() {
    Provider.of<MovieDetailsViewModel>(context, listen: false)
        .initDetails(widget.movieModel);
  }

  @override
  Widget build(BuildContext context) {
    try {
      return SafeArea(
        child: Consumer<MovieDetailsViewModel>(
          builder: (context, value, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              extendBodyBehindAppBar: true,
              body: value.isLoading
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
                                image: NetworkImage(
                                    '${value.details[1][0].image}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ListView(
                            children: [
                              Container(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                            '${value.details[0].title}',
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
                                              onTap: () =>
                                                  value.updateFavorite(),
                                              child:
                                                  value.movieData.favorite == 1
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
                                              '${value.details[0].rating.toStringAsFixed(1)}/10 IMDb',
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: SizedBox(
                                        height: 22,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              value.details[0].genres.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  right: 15),
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                  getGenre(value.details[0]
                                                      .genres[index]['id']),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10,),
                                      child: SizedBox(
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: value.items.length,
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
                                                      value.items[index]['key'],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF919191),
                                                        fontFamily: 'SF_Pro',
                                                      ),
                                                    ),
                                                    Text(
                                                      value.items[index]
                                                          ['value'],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                      ),
                                    ),
                                    Container(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: const Text(
                                        'Description',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'SF_Pro',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: ReadMoreText(
                                        '${value.details[0].overview}',
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
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: SizedBox(
                                        height: 160,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: value.details[2].length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CastDetailScreen(
                                                      id: value
                                                          .details[2][index].id,
                                                      isHome: true,
                                                    ),
                                                  ),
                                                  (Route<dynamic> route) =>
                                                      true,
                                                );
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 80,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 20,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          value
                                                              .details[2][index]
                                                              .image,
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
                                                        '${value.details[2][index].name}',
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
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
            );
          },
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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
