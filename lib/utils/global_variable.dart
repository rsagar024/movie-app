import 'package:flutter/material.dart';
import 'package:movie_app/resource/movie_list.dart';
import 'package:movie_app/screens/movie_dashboard.dart';
import 'package:movie_app/screens/notification_screen.dart';
import 'package:movie_app/screens/profile_screen.dart';
import 'package:movie_app/widgets/biography_page.dart';
import 'package:movie_app/widgets/directory_page.dart';
import 'package:movie_app/widgets/featured_page.dart';
import 'package:movie_app/widgets/message_page.dart';
import 'package:movie_app/widgets/promo_page.dart';
import 'package:movie_app/widgets/update_page.dart';

List<Widget> homeScreenItems = [
  const MovieDashboard(),
  const MovieLists(
    title: 'My Favorite',
    // size: 10,
    isGenres: true,
  ),
  const NotificationScreen(),
  const ProfileScreen(),
];

List<Widget> items = [
  const BiographyPage(),
  const FeaturedPage(),
  const DirectoryPage(),
];

List<Widget> notifyItems = [
  const UpdatePage(),
  const MessagePage(),
  const PromoPage(),
];

int result = 0;
