import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/notification_model.dart';
import 'package:movie_app/core/repository/movie_repository.dart';
import 'package:movie_app/core/utils/database_methods.dart';
import 'package:movie_app/core/utils/notification_database_methods.dart';
import 'package:movie_app/core/utils/notify_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class MovieDashboardViewModel extends ChangeNotifier {
  late DatabaseMethods _databaseMethods;
  late NotificationDatabaseMethods _notificationDatabaseMethods;
  bool isLoading = false;
  List<List<MovieModel>> movie = [];
  List<CastInfo> cast = [];
  List<MovieModel> movieDb = [];
  List<MovieModel> scrollMovies = [];

  void initDashboard() async {
    isLoading = true;
    notifyListeners();
    getDatabase();
    getDetails();
  }

  void getDatabase() async {
    _databaseMethods = DatabaseMethods();
    _notificationDatabaseMethods = NotificationDatabaseMethods();
    Database database = await _databaseMethods.database;
    Database notifyDatabase = await _notificationDatabaseMethods.notifyDatabase;
    if (database != null && notifyDatabase != null) {
      movieDb = await _databaseMethods.getMovieList();
      await _notificationDatabaseMethods.getNotifyCount();
    }
  }

  void getDetails() async {
    movie = await MovieRepository().getHomePageMovies();
    var data = await MovieRepository().getMovieDetails('10757');

    if (movie.isNotEmpty) {
      cast.addAll(data[2]);
      cast.shuffle();
      for (int i = 0; i < movieDb.length; i++) {
        for (int j = 0; j < movie[0].length; j++) {
          if (movieDb[i].id == movie[0][j].id) {
            movie[0][j].favorite = 1;
            break;
          }
        }
      }
      for (int i = 0; i < movieDb.length; i++) {
        for (int j = 0; j < movie[3].length; j++) {
          if (movieDb[i].id == movie[3][j].id) {
            movie[3][j].favorite = 1;
            break;
          }
        }
      }

      scrollMovies.add(movie[1][0]);
      scrollMovies.add(movie[1][2]);
      scrollMovies.add(movie[1][1]);
      scrollMovies.add(movie[1][4]);
      scrollMovies.add(movie[1][3]);
      scrollMovies.add(movie[1][6]);
      scrollMovies.add(movie[1][7]);

      isLoading = false;
      notifyListeners();

      print('Movies : $movie');
      print('Database Movies : $movieDb');
      print('Scroll Movies : $scrollMovies');
      print('Cast : $cast');
    }
  }

  bool isPresent(String id) {
    for (int i = 0; i < movieDb.length; i++) {
      if (movieDb[i].id == id) {
        return true;
      }
    }
    return false;
  }

  void updateFavorite(int index, int movieIndex) async {
    if (movie[movieIndex][index].favorite == 0) {
      if (!isPresent(movie[movieIndex][index].id)) {
        movie[movieIndex][index].favorite = 1;
        int id = const Uuid().v1().hashCode;
        NotificationModel notifyModel = NotificationModel(
          id: '$id',
          title: 'Favorite Movie',
          body: '${movie[movieIndex][index].title} added to the Favorite Screen',
          payload: 'https://my-movie-1432.web.app?id=${movie[movieIndex][index].id}*$id',
          date: DateFormat.yMd().add_jm().format(DateTime.now()),
        );

        NotificationService().showNotification(
          id: notifyModel.id.hashCode,
          title: notifyModel.title,
          body: notifyModel.body,
          payload: notifyModel.payload,
        );

        await _notificationDatabaseMethods.insertNotify(notifyModel);
        await _databaseMethods.insertMovie(movie[movieIndex][index]);
        movieDb = await _databaseMethods.getMovieList();
      }
      movie[movieIndex][index].favorite = 1;
    } else {
      if (isPresent(movie[movieIndex][index].id)) {
        movie[movieIndex][index].favorite = 0;
        await _databaseMethods.deleteMovie(movie[movieIndex][index].id);
        movieDb = await _databaseMethods.getMovieList();
      }
      movie[movieIndex][index].favorite = 0;
    }
    notifyListeners();
  }
}
