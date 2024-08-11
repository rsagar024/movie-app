import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/network/i_network_service.dart';
import 'package:movie_app/core/network/network_service_impl.dart';

class MovieRepository {
  final INetworkService _service = NetworkServiceImpl();

  Future<List<List<MovieModel>>> getHomePageMovies() async {
    MovieModelList trendingData;
    MovieModelList nowPlayingData;
    MovieModelList topRatedData;
    MovieModelList upcomingData;

    var response = await _service.getHomePageMovies();
    trendingData = MovieModelList.fromJson(response['trandingMovies']);
    nowPlayingData = MovieModelList.fromJson(response['nowPlayingMovies']);
    topRatedData = MovieModelList.fromJson(response['topRatedMovies']);
    upcomingData = MovieModelList.fromJson(response['upcoming']);

    return [
      trendingData.movies,
      nowPlayingData.movies,
      topRatedData.movies,
      upcomingData.movies,
    ];
  }

  Future<List<dynamic>> getMovieDetails(String id) async {
    MovieInfoModel movieData;
    MovieInfoImdb imdbData;
    ImageBackdropList backdropsData;
    CastInfoList castData;
    MovieModelList similarData;

    var images = [];
    var response = await _service.getMovieDetails(id);
    movieData = MovieInfoModel.fromJson(response['data']);
    // trailersData = TrailerList.fromJson(movie['videos']);
    images.addAll(response['images']['backdrops']);
    images.addAll(response['images']['posters']);
    images.addAll(response['images']['logos']);

    backdropsData = ImageBackdropList.fromJson(images);

    castData = CastInfoList.fromJson(response['credits']);
    similarData = MovieModelList.fromJson(response['similar']['results']);

    var imdbId = movieData.imdbId;
    final omdbResponse = await _service.getIMDBMovieDetails(imdbId);
    imdbData = MovieInfoImdb.fromJson(omdbResponse['data']);

    return [
      movieData,
      backdropsData.backdrops,
      castData.castList,
      imdbData,
      similarData.movies,
    ];
  }

  Future<List<dynamic>> getMoviesGenre(String query, int page) async {
    var response = await _service.getMoviesGenre(query, page);
    return [
      (response['data'] as List)
          .map((list) => MovieModel.fromJson(list))
          .toList(),
      response['total_pages'],
    ];
  }

  Future<List<dynamic>> getMovies(String query, int page) async {
    var response = await _service.getMovies(query, page);
    return [
      (response['data'] as List)
          .map((list) => MovieModel.fromJson(list))
          .toList(),
      response['total_pages'],
    ];
  }

  Future<List<dynamic>> getPersons(String query, int page) async {
    var response = await _service.getMovies(query, page);
    return [
      (response['data'] as List)
          .map((list) => MovieModel.fromJson(list))
          .toList(),
      response['total_pages'],
    ];
  }
}
