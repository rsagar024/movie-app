import 'package:flutter/material.dart';
import 'package:movie_app/core/models/formatted_month_generator.dart';

class MovieModel {
  final String title;
  final String poster;
  final String id;
  final List genres;
  final String backdrop;
  final double voteAverage;
  final String releaseDate;
  int favorite;

  MovieModel({
    required this.title,
    required this.poster,
    required this.id,
    required this.genres,
    required this.backdrop,
    required this.voteAverage,
    required this.releaseDate,
    this.favorite = 0,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    var date = 'Not Available';
    getDate() {
      try {
        date =
            '${monthGenerator(json['release_date'].split("-")[1])} ${json['release_date'].split("-")[2]}, ${json['release_date'].split("-")[0]}';
      } catch (e) {
        debugPrint('Error');
      }
    }

    getDate();
    return MovieModel(
      backdrop: json['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : 'https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg',
      poster: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg',
      id: json['id'].toString(),
      title: json['title'] ?? '',
      genres: (json['genre_ids'] as List).map((genre) => genre).toList(),
      voteAverage: json['vote_average'].toDouble() ?? 0.0,
      releaseDate: date,
      favorite: 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'poster': poster,
        'genres': genres.join(','), // Assuming genres is a list of strings
        'backdrop': backdrop,
        'voteAverage': voteAverage,
        'releaseDate': releaseDate,
      };

  Map<String, dynamic> toMap2() => {
        'id': id,
        'title': title,
        'poster': poster,
        'genres': genres.join(','), // Convert genres list to string for storage
        'backdrop': backdrop,
        'voteAverage': voteAverage,
        'releaseDate': releaseDate,
        'favorite': favorite,
      };

  static MovieModel fromMap(Map<String, dynamic> map) => MovieModel(
        title: map['title'] as String,
        poster: map['poster'] as String,
        id: map['id'] as String,
        genres:
            (map['genres'] as String).split(','), // Convert string back to list
        backdrop: map['backdrop'] as String,
        voteAverage: map['voteAverage'] as double,
        releaseDate: map['releaseDate'] as String,
        favorite: map['favorite'] as int,
      );
}

class MovieModelList {
  final List<MovieModel> movies;
  MovieModelList({
    required this.movies,
  });
  factory MovieModelList.fromJson(List<dynamic> json) {
    return MovieModelList(
        movies: (json).map((list) => MovieModel.fromJson(list)).toList());
  }
}

class MovieInfoModel {
  final String tmdbId;
  final String overview;
  final String title;
  // final List language;
  final String backdrops;
  final String poster;
  final int budget;
  final String tagline;
  final double rating;
  final String dateByMonth;
  final int runtime;
  final String homepage;
  final String imdbId;
  final List genres;
  final String releaseDate;

  MovieInfoModel({
    required this.tmdbId,
    required this.overview,
    required this.title,
    // required this.language,
    required this.backdrops,
    required this.poster,
    required this.budget,
    required this.tagline,
    required this.rating,
    required this.dateByMonth,
    required this.runtime,
    required this.homepage,
    required this.imdbId,
    required this.genres,
    required this.releaseDate,
  });

  factory MovieInfoModel.fromJson(Map<String, dynamic> json) {
    var date = 'Not Available';
    getDate() {
      try {
        date =
            '${monthGenerator(json['release_date'].split("-")[1])} ${json['release_date'].split("-")[2]}, ${json['release_date'].split("-")[0]}';
      } catch (e) {
        debugPrint('Error');
      }
    }

    getDate();
    return MovieInfoModel(
      budget: json['budget'],
      title: json['title'] ?? '',
      homepage: json['homepage'] ?? '',
      imdbId: json['imdb_id'] ?? '',
      // language: (json['spoken_language'] as List)
      //     .map((lang) => lang)
      //     .toList(),
      genres: (json['genres'] as List).map((genre) => genre).toList(),
      overview: json['overview'] ?? json['actors'] ?? '',
      backdrops: json['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : 'https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg',
      poster: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg',
      rating: json['vote_average'].toDouble() ?? 0.0,
      runtime: json['runtime'],
      tagline: json['tagline'] ?? json['actors'] ?? '',
      tmdbId: json['id'].toString(),
      releaseDate: json['release_date'] ?? '',
      dateByMonth: date,
    );
  }
}

class MovieInfoImdb {
  final String genre;
  final String runtime;
  final String director;
  final String writer;
  final String actors;
  final String language;
  final String awards;
  final String released;
  final String country;
  final String boxOffice;
  final String year;
  final String rated;
  final String plot;
  final String production;
  MovieInfoImdb({
    required this.genre,
    required this.runtime,
    required this.director,
    required this.writer,
    required this.actors,
    required this.language,
    required this.awards,
    required this.released,
    required this.country,
    required this.boxOffice,
    required this.year,
    required this.rated,
    required this.plot,
    required this.production,
  });
  factory MovieInfoImdb.fromJson(json) {
    return MovieInfoImdb(
      actors: json['Actors'] ?? '',
      rated: json['Rated'] ?? '',
      production: json['Production'] ?? '',
      plot: json['Plot'] ?? '',
      awards: json['Awards'] ?? '',
      director: json['Director'] ?? '',
      genre: json['Genre'] ?? '',
      language: json['Language'] ?? '',
      released: json['Released'] ?? '',
      runtime: json['Runtime'] ?? '',
      writer: json['Writer'] ?? '',
      year: json['Year'].toString(),
      boxOffice: json['BoxOffice'].toString(),
      country: json['Country'] ?? '',
    );
  }
}

class ImageBackdrop {
  final String image;
  ImageBackdrop({
    required this.image,
  });
  factory ImageBackdrop.fromJson(json) {
    return ImageBackdrop(
      image: 'https://image.tmdb.org/t/p/original${json['file_path']}',
    );
  }
}

class ImageBackdropList {
  final List<ImageBackdrop> backdrops;

  ImageBackdropList({
    required this.backdrops,
  });

  factory ImageBackdropList.fromJson(backdrops) {
    return ImageBackdropList(
      backdrops: (backdrops as List)
          .map((backdrop) => ImageBackdrop.fromJson(backdrop))
          .toList(),
    );
  }
}

class CastInfo {
  final String name;
  final String character;
  final String image;
  final String id;
  final String department;
  final double popularity;
  final String gender;
  CastInfo({
    required this.name,
    required this.character,
    required this.image,
    required this.id,
    required this.department,
    required this.popularity,
    required this.gender,
  });
  factory CastInfo.fromJson(json) {
    return CastInfo(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      image: json['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['profile_path']}'
          : 'https://media.istockphoto.com/id/517998264/vector/male-user-icon.jpg?s=612x612&w=0&k=20&c=4RMhqIXcJMcFkRJPq6K8h7ozuUoZhPwKniEke6KYa_k=',
      department: json['known_for_department'] ?? '',
      popularity: json['popularity'].toDouble() ?? 0.0,
      gender: json['gender'] == 2 ? 'Male' : 'Female',
    );
  }
}

class CastInfoList {
  final List<CastInfo> castList;
  CastInfoList({
    required this.castList,
  });
  factory CastInfoList.fromJson(json) {
    return CastInfoList(
      castList: ((json['cast'] ?? []) as List)
          .map((cast) => CastInfo.fromJson(cast))
          .toList(),
    );
  }
}
