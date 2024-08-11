import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/api/key.dart';
import 'package:movie_app/core/network/i_network_service.dart';

class NetworkServiceImpl extends INetworkService {
  @override
  Future<dynamic> getHomePageMovies() async {
    final response = await http.get(
      Uri.parse('$BASE_URL/home'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<dynamic> getMovieDetails(String id) async {
    var response = await http.get(Uri.parse('$BASE_URL/movie/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Something went wrong');
    }
  }

  @override
  Future<dynamic> getIMDBMovieDetails(String id) async {
    var response = await http.get(Uri.parse('$BASE_URL/movie/omdb/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Something went wrong');
    }
  }

  @override
  Future<dynamic> getCastDetails(String id) async {
    var response = await http.get(Uri.parse('$BASE_URL/person/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failure to fetch data');
    }
  }

  @override
  Future<dynamic> getMoviesGenre(String query, int page) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/genre/movie?id=$query&page=${page.toString()}'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Something went wrong!");
    }
  }

  @override
  Future<dynamic> getMovies(String query, int page) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/search/movie?text=$query&page=${page.toString()}'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Something went wrong!");
    }
  }

  @override
  Future<dynamic> getPersons(String query, int page) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/search/tv?text=$query&page=${page.toString()}'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Something went wrong!");
    }
  }
}
