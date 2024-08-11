import 'package:flutter/material.dart';
import 'package:movie_app/core/widgets/biography_page.dart';
import 'package:movie_app/core/widgets/directory_page.dart';
import 'package:movie_app/core/widgets/featured_page.dart';
import 'package:movie_app/core/widgets/message_page.dart';
import 'package:movie_app/core/widgets/promo_page.dart';
import 'package:movie_app/core/widgets/update_page.dart';
import 'package:movie_app/resource/movie_list.dart';
import 'package:movie_app/view/movie_dashboard.dart';
import 'package:movie_app/view/notification_screen.dart';
import 'package:movie_app/view/profile_screen.dart';

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
