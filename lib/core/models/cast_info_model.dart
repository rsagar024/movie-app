import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/models/formatted_month_generator.dart';

class CastPersonalInfo {
  final String image;
  final String name;
  final String bio;
  final String id;
  final String birthday;
  final String placeOfBirth;
  final String knownFor;
  final String imdbId;
  final String old;
  final String gender;

  CastPersonalInfo({
    required this.image,
    required this.name,
    required this.bio,
    required this.id,
    required this.birthday,
    required this.placeOfBirth,
    required this.knownFor,
    required this.imdbId,
    required this.old,
    required this.gender,
  });

  factory CastPersonalInfo.fromJson(Map<String, dynamic> json) {
    getYears(String birthDateString) {
      String datePattern = 'yyyy-MM-dd';

      DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
      DateTime today = DateTime.now();

      int yearDiff = today.year - birthDate.year;
      return yearDiff;
    }

    var date = 'Not Available';
    getDate() {
      try {
        date =
            '${monthGenerator(json['release_date'].split("-")[1])} ${json['release_date'].split("-")[2]}, ${json['release_date'].split("-")[0]}';
      } catch (e) {
        debugPrint('Error');
      }
    }

    return CastPersonalInfo(
      image: json['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/original${json['profile_path']}'
          : 'https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg',
      bio: json['biography'] ?? '',
      id: json['id'].toString(),
      imdbId: json['imdb_id'] ?? '',
      name: json['name'] ?? '',
      placeOfBirth: json['place_of_birth'] ?? '',
      knownFor: json['known_for_department'] ?? '',
      gender: json['gender'] == 2 ? 'Male' : 'Female',
      birthday: date,
      old: json['birthday'] != null
          ? '${getYears(json['birthday']).toString()} years'
          : 'N/A',
    );
  }
}

class SocialMediaInfo {
  final String facebook;
  final String instagram;
  final String twitter;
  // final String imdbId;
  SocialMediaInfo({
    required this.facebook,
    required this.instagram,
    required this.twitter,
    // required this.imdbId,
  });
  factory SocialMediaInfo.fromJson(json) {
    return SocialMediaInfo(
      facebook: json['facebook_id'] != null
          ? 'https://facebook.com/${json['facebook_id']}'
          : '',
      instagram: json['instagram_id'] != null
          ? 'https://www.instagram.com/${json['instagram_id']}'
          : '',
      twitter: json['twitter_id'] != null
          ? 'https://twitter.com/${json['twitter_id']}'
          : '',
      // imdbId: json['imdb_id'] != null
      //     ? "https://www.imdb.com/name/" + json['imdb_id']
      //     : "",
    );
  }
}
