import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/api/key.dart';
import 'package:movie_app/models/movie_model.dart';

class FetchMovieDataById {
  Future<List<dynamic>> getDetails(String id) async {
    MovieInfoModel movieData;
    MovieInfoImdb imdbData;
    ImageBackdropList backdropsData;
    CastInfoList castData;
    MovieModelList similarData;

    /*var images = [];
    dynamic movie;
    dynamic cast;
    dynamic image;
    // dynamic imdb;

    final response = await http.get(Uri.parse('$BASE_URL2/movie/$id'),headers: headers);
    final response1 = await http.get(Uri.parse('$BASE_URL2/movie/$id/images'),headers: headers);
    final response2 = await http.get(Uri.parse('$BASE_URL2/movie/$id/credits'),headers: headers);
    // print(response.statusCode);
    if (response.statusCode == 200 || response1.statusCode==200 || response2.statusCode==200) {
      movie = jsonDecode(response.body);
      image = jsonDecode(response1.body);
      cast = jsonDecode(response2.body);
      // imdb = jsonDecode(response3.body);
      // print(movie);
    } else {
      throw Exception('Something went wrong');
    }

    movieData = MovieInfoModel.fromJson(movie);
    // images.addAll(movie['images']['backdrops']);
    // images.addAll(movie['images']['posters']);
    // images.addAll(movie['images']['logos']);
    images.addAll(image['backdrops']);
    images.addAll(image['posters']);
    images.addAll(image['logos']);

    backdropsData = ImageBackdropList.fromJson(images);

    castData = CastInfoList.fromJson(cast);
    // similarData = MovieModelList.fromJson(movie['similar']['results']);

    // var imdbId = movieData.imdbId;
    // final imdbResponse =
    //     await http.get(Uri.parse('$BASE_URL/movie/omdb/${imdbId.toString()}'));
    // if (imdbResponse.statusCode == 200) {
    //   imdbData = MovieInfoImdb.fromJson(jsonDecode(imdbResponse.body)['data']);
    // } else {
    //   throw Exception('Error Fetching data');
    // }

    final response3 = await http.get(Uri.parse('$OMDB_URL${movieData.imdbId}'));
    imdbData = MovieInfoImdb.fromJson(jsonDecode(response3.body));*/

    var images = [];
    dynamic movie;
    var response = await http.get(Uri.parse('$BASE_URL/movie/$id'));
    if (response.statusCode == 200) {
      movie = jsonDecode(response.body);
    } else {
      throw Exception('Something went wrong');
    }

    movieData = MovieInfoModel.fromJson(movie['data']);
    // trailersData = TrailerList.fromJson(movie['videos']);
    images.addAll(movie['images']['backdrops']);
    images.addAll(movie['images']['posters']);
    images.addAll(movie['images']['logos']);

    backdropsData = ImageBackdropList.fromJson(images);

    castData = CastInfoList.fromJson(movie['credits']);
    similarData = MovieModelList.fromJson(movie['similar']['results']);

    var imdbId = movieData.imdbId;
    final omdbResponse =
    await http.get(Uri.parse('$BASE_URL/movie/omdb/$imdbId'));
    if (omdbResponse.statusCode == 200) {
      imdbData = MovieInfoImdb.fromJson(jsonDecode(omdbResponse.body)['data']);
    } else {
      throw Exception('Error Fetching data');
    }

    return [
      movieData,
      backdropsData.backdrops,
      castData.castList,
      imdbData,
      similarData.movies,
    ];
  }
}
