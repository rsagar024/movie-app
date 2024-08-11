import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/global_variable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
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
    return Scaffold(
      body: Container(
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
          children: [
            SizedBox(
              height: 25,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Flexible(
                    child: Container(),
                  ),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 23,
                      color: Color(0xFF272F4B),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF_Pro',
                    ),
                  ),
                  Flexible(
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
                'Showing $result Results',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF616161),
                  fontFamily: 'SF_Pro',
                ),
              ),
            ),

            /// Buttons
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      navigationTapped(0);
                      setState(() {});
                    },
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
                              'Update',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'SF_Pro',
                              ),
                            )
                          : const Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'SF_Pro',
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        navigationTapped(1);
                        setState(() {});
                      },
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
                                'Message',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'SF_Pro',
                                ),
                              )
                            : const Text(
                                'Message',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'SF_Pro',
                                ),
                              ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigationTapped(2);
                      setState(() {});
                    },
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
                              'Promo',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'SF_Pro',
                              ),
                            )
                          : const Text(
                              'Promo',
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

            Flexible(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: onPageChanged,
                children: notifyItems,
              ),
            ),

            const SizedBox(
              height: 55,
            ),
          ],
        ),
      ),
    );
  }
}
