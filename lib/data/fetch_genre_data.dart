import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/api/key.dart';
import 'package:movie_app/core/models/movie_model.dart';

class GenreResultRepo {
  Future<List<dynamic>> getMovies(String query, int page) async {
    final response = await http.get(
        // Uri.parse('$BASE_URL2/genre/movie?id=$query&page=${page.toString()}'),headers: headers);
        Uri.parse('$BASE_URL/genre/movie?id=$query&page=${page.toString()}'));

    if (response.statusCode == 200) {
      return [
        (jsonDecode(response.body)['data'] as List)
            .map((list) => MovieModel.fromJson(list))
            .toList(),
        jsonDecode(response.body)['total_pages'],
      ];
    } else {
      throw Exception("Something went wrong!");
    }
  }
}
