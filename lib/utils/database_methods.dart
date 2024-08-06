import 'dart:io';

import 'package:movie_app/models/movie_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMethods {
  static DatabaseMethods? _databaseMethods;
  static Database? _database;
  // static Database? _notifyDatabase;

  String movieDb = 'movie_db';
  // String notifyDb = 'notify_db';
  DatabaseMethods._createInstance();

  factory DatabaseMethods() {
    _databaseMethods ??= DatabaseMethods._createInstance();
    return _databaseMethods!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}movie.db';

    //Open/Create the database at a given path
    var movieDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return movieDb;
  }

  void _createDb(Database db, int newVersion) async {
    const moviesTableSql = '''
      CREATE TABLE movie_db (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        poster TEXT,
        genres TEXT,
        backdrop TEXT,
        voteAverage REAL,
        releaseDate TEXT,
        favorite INTEGER NOT NULL DEFAULT 0  -- Default favorite to false (0)
      )
    ''';
    await db.execute(moviesTableSql);
  }

  /// CRUD operations in movie_db table
  // Fetch Operation : Get all Movie objects from database
  Future<List<Map<String, dynamic>>> getMovieMapList() async {
    Database db = await database;
    // var result = await db.rawQuery('SELECT * FROM $userTable');
    var result = await db.query(movieDb);
    return result;
  }

  // Insert Operation : Insert a Movie object to database
  Future<int> insertMovie(MovieModel movie) async {
    Database db = await database;
    int result = await db.insert(movieDb, movie.toMap2());
    return result;
  }

  // Delete Operation : Delete a Movie object from database
  Future<int> deleteMovie(String id) async {
    Database db = await database;
    int result = await db.delete(movieDb, where: 'id = $id');
    return result;
  }

  // Get number of Movie objects in database
  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> movies =
        await db.rawQuery('SELECT COUNT (*) FROM $movieDb');
    int result = Sqflite.firstIntValue(movies) ?? 0;
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Movie List' [ List<MovieModel> ]
  Future<List<MovieModel>> getMovieList() async {
    var movieMapList = await getMovieMapList(); // Get 'Map List' from database

    List<MovieModel> movieList = <MovieModel>[];
    // for (int i = 0; i < movieMapList.length; i++) {
    for (int i = movieMapList.length - 1; i >= 0; i--) {
      movieList.add(MovieModel.fromMap(movieMapList[i]));
    }
    return movieList;
  }
}
