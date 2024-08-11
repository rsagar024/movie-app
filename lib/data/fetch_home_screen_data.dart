import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/api/key.dart';
import 'package:movie_app/core/models/movie_model.dart';

class FetchHomeRepo {
  Future<List<dynamic>> getHomePageMovies() async {
    MovieModelList trendingData;
    MovieModelList nowPlayingData;
    MovieModelList topRatedData;
    MovieModelList upcomingData;

    /*final response1 = await http.get(
      Uri.parse('$BASE_URL2/movie/popular?api_key=390d7c348a206b4b980034e900b563d9'),
      // headers: headers,
    );
    final response2 = await http.get(
      Uri.parse('$BASE_URL2/movie/now_playing?api_key=390d7c348a206b4b980034e900b563d9'),
      // headers: headers,
    );
    final response3 = await http.get(
      Uri.parse('$BASE_URL2/movie/top_rated?api_key=390d7c348a206b4b980034e900b563d9'),
      // headers: headers,
    );
    final response4 = await http.get(
      Uri.parse('$BASE_URL2/movie/upcoming?api_key=390d7c348a206b4b980034e900b563d9'),
      // headers: headers,
    );

    if (response1.statusCode == 200 ||
        response2.statusCode == 200 ||
        response3.statusCode == 200 ||
        response4.statusCode == 200) {
      print('Success');
      trendingData =
          MovieModelList.fromJson(json.decode(response1.body)['results']);
      nowPlayingData =
          MovieModelList.fromJson(json.decode(response2.body)['results']);
      topRatedData =
          MovieModelList.fromJson(json.decode(response3.body)['results']);
      upcomingData =
          MovieModelList.fromJson(json.decode(response4.body)['results']);*/

    final response = await http.get(
      Uri.parse('$BASE_URL/home'),
    );
    if (response.statusCode == 200) {
      trendingData =
          MovieModelList.fromJson(json.decode(response.body)['trandingMovies']);
      nowPlayingData = MovieModelList.fromJson(
          json.decode(response.body)['nowPlayingMovies']);
      topRatedData =
          MovieModelList.fromJson(json.decode(response.body)['topRatedMovies']);
      upcomingData =
          MovieModelList.fromJson(json.decode(response.body)['upcoming']);

      return [
        trendingData.movies,
        nowPlayingData.movies,
        topRatedData.movies,
        upcomingData.movies,
      ];
    } else {
      throw Exception('Faild to load data');
    }

    /*final response = await http.get(
      Uri.parse('$BASE_URL/home'),
    );

    if (response.statusCode == 200) {
      trendingData =
          MovieModelList.fromJson(json.decode(response.body)['trandingMovies']);
      nowPlayingData = MovieModelList.fromJson(
          json.decode(response.body)['nowPlayingMovies']);
      topRatedData =
          MovieModelList.fromJson(json.decode(response.body)['topRatedMovies']);
      upcomingData =
          MovieModelList.fromJson(json.decode(response.body)['upcoming']);

      return [
        trendingData.movies,
        nowPlayingData.movies,
        topRatedData.movies,
        upcomingData.movies,
      ];
    } else {
      throw Exception('Failed to load data');
    }*/
  }
}
