import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/utils/context_utility.dart';
import 'package:movie_app/core/utils/database_methods.dart';
import 'package:movie_app/core/utils/notification_database_methods.dart';
import 'package:movie_app/view/movie_detail_screen.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/notification_model.dart';
import 'package:uni_links/uni_links.dart';

class UniServices {
  static String _id = '';
  static String get id => _id;
  static bool get hasId => _id.isNotEmpty;
  static List _movieDb = [];
  static List _notifyDb = [];
  late DatabaseMethods _databaseMethods;
  late NotificationDatabaseMethods _notificationDatabaseMethods;
  static MovieModel? _movie;
  static NotificationModel? _notify;
  static String? _notifyId;

  static void reset() => _id = '';

  static init() async {
    try {
      final Uri? uri = await getInitialUri();
      uniHandler(uri);
    } on PlatformException {
      log('Failed to receive the code' as num);
    } on FormatException {
      log('Wrong format code received' as num);
    }

    uriLinkStream.listen((Uri? uri) async {
      uniHandler(uri);
    }, onError: (error) {
      log('OnUriLink Error : $error' as num);
    });
  }

  static splitUrl(String url) {
    List<String> urlParts = url.split('*');
    if (urlParts.length == 1) {
      return url;
    }
    _notifyId = urlParts[1];
    return urlParts[0];
  }

  static uniHandler(Uri? uri) async {
    if (uri == null || uri.queryParameters.isEmpty) return;
    uri = Uri.parse(splitUrl(uri.toString()));
    Map<String, String> param = uri.queryParameters;
    String receivedId = param['id'] ?? '';
    // print(receivedId.runtimeType);
    await UniServices().getDatabase();

    if (receivedId.isNotEmpty) {
      // print(_movie);
      _movie = UniServices().isPresent(receivedId);
      _notify = UniServices().isChecked(_notifyId!);
      print(_movie);
      print(receivedId);
      print(_notifyDb[0].id);
      if (_movie != null && _notify != null) {
        if (_notify!.click == 0) {
          _notify!.click = 1;
          await NotificationDatabaseMethods().updateNotify(_notify!);
        }
        Navigator.pushAndRemoveUntil(
          ContextUtility.context!,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              movieModel: _movie!,
            ),
          ),
          (Route<dynamic> route) => true,
        );
      } else {
        print('hello');
      }
    }
  }

  Future<void> getDatabase() async {
    _databaseMethods = DatabaseMethods();
    _notificationDatabaseMethods = NotificationDatabaseMethods();
    _movieDb = await _databaseMethods.getMovieList();
    _notifyDb = await _notificationDatabaseMethods.getNotifyList();
    // print(_movieDb);
  }

  MovieModel? isPresent(String id) {
    for (int i = 0; i < _movieDb.length; i++) {
      if (_movieDb[i].id == id) {
        return _movieDb[i];
      }
    }
    return null;
  }

  NotificationModel? isChecked(String id) {
    for (int i = 0; i < _notifyDb.length; i++) {
      if (_notifyDb[i].id == id) {
        return _notifyDb[i];
      }
    }
    return null;
  }
}
