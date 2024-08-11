import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/api/key.dart';
import 'package:movie_app/core/models/cast_info_model.dart';
import 'package:movie_app/core/models/movie_model.dart';

class FetchCastInfoById {
  Future<List<dynamic>> getCastDetails(String id) async {
    CastPersonalInfo castInfo;
    SocialMediaInfo socialMedia;
    ImageBackdropList backdrops;
    MovieModelList movies;

    /*final response = await http.get(Uri.parse('$BASE_URL2/person/$id'),headers: headers);
    final response1 = await http.get(Uri.parse('$BASE_URL2/person/$id/images'),headers: headers);
    final response2 = await http.get(Uri.parse('$BASE_URL2/person/$id/movie_credits'),headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var data1 = jsonDecode(response1.body);
      var data2 = jsonDecode(response2.body);
      castInfo = CastPersonalInfo.fromJson(data);
      // socialMedia = SocialMediaInfo.fromJson(data['socialmedia']);
      backdrops = ImageBackdropList.fromJson(data1['profiles']);
      movies = MovieModelList.fromJson(data2['cast']);*/

    var response = await http.get(Uri.parse('$BASE_URL/person/$id'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      castInfo = CastPersonalInfo.fromJson(data['data']);
      socialMedia = SocialMediaInfo.fromJson(data['socialmedia']);
      backdrops = ImageBackdropList.fromJson(data['images']['profiles']);

      movies = MovieModelList.fromJson(data['movies']['cast']);

      return [
        castInfo,
        socialMedia,
        backdrops.backdrops,
        movies.movies,
      ];
    } else {
      throw Exception('Failure to fetch data');
    }
  }
}
