import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/notification_model.dart';
import 'package:movie_app/core/repository/movie_repository.dart';
import 'package:movie_app/core/utils/database_methods.dart';
import 'package:movie_app/core/utils/notification_database_methods.dart';
import 'package:movie_app/core/utils/notify_service.dart';
import 'package:movie_app/data/call_methods.dart';
import 'package:uuid/uuid.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  bool isLoading = false;
  var details = [];
  bool isFavorite = false;
  bool isClicked = false;
  late MovieModel movieData;
  List movieDb = [];
  late DatabaseMethods _databaseMethods;
  late NotificationDatabaseMethods _notificationDatabaseMethods;
  List<Map<String, dynamic>> items = [
    {'key': 'Length', 'value': []},
    {'key': 'Language', 'value': []},
    {'key': 'Rating', 'value': []}
  ];

  void initDetails(MovieModel movieData) async {
    isLoading = true;
    getDetails(movieData.id);
    getDatabase();
    this.movieData = movieData;
  }

  void getDetails(String id) async {
    details = await MovieRepository().getMovieDetails(id);
    if (details.isNotEmpty) {
      items[0]['value'] = getDuration(details[3].runtime);
      items[1]['value'] = '${details[3].language}';
      items[2]['value'] = '${details[3].rated}';
      isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Error');
    }
  }

  void getDatabase() async {
    _databaseMethods = DatabaseMethods();
    _notificationDatabaseMethods = NotificationDatabaseMethods();
    await _databaseMethods.database;
    await _notificationDatabaseMethods.notifyDatabase;
    movieDb = await _databaseMethods.getMovieList();
  }

  void updateFavorite() async {
    if (movieData.favorite == 0) {
      movieData.favorite = 1;
      int id = const Uuid().v1().hashCode;
      NotificationModel notifyModel = NotificationModel(
        id: '$id',
        title: 'Favorite Movie',
        body: '${movieData.title} added to the Favorite Screen',
        payload: 'https://my-movie-1432.web.app?id=${movieData.id}*$id',
        date: DateFormat.yMd().add_jm().format(DateTime.now()),
      );
      NotificationService().showNotification(
        id: int.parse(notifyModel.id),
        title: notifyModel.title,
        body: notifyModel.body,
        payload: notifyModel.payload,
      );
      await _notificationDatabaseMethods.insertNotify(notifyModel);
      await _databaseMethods.insertMovie(movieData);
      movieDb = await _databaseMethods.getMovieList();
      movieData.favorite = 1;
    } else {
      movieData.favorite = 0;
      await _databaseMethods.deleteMovie(movieData.id);
      movieDb = await _databaseMethods.getMovieList();
      movieData.favorite = 0;
    }
  }
}
