import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/global_variable.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _page = 0;
  late PageController pageController;

  List<IconData> navIcons = [
    Icons.home_filled,
    Icons.favorite,
    Icons.notifications,
    Icons.person,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
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
        body: Stack(
          children: [
            // const MovieDashboard(),
            // const FavoriteScreen(),
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: onPageChanged,
              children: homeScreenItems,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 7,
                ).copyWith(top: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 20,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: navIcons
                      .asMap()
                      .entries
                      .map((MapEntry<int, IconData> entry) => GestureDetector(
                            onTap: () => navigationTapped(entry.key),
                            child: Icon(
                              navIcons[entry.key],
                              color: _page == entry.key
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
