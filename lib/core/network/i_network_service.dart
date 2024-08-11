abstract class INetworkService{
  Future<dynamic> getHomePageMovies();
  Future<dynamic> getMovieDetails(String id);
  Future<dynamic> getIMDBMovieDetails(String id);
  Future<dynamic> getCastDetails(String id);
  Future<dynamic> getMoviesGenre(String query, int page);
  Future<dynamic> getMovies(String query, int page);
  Future<dynamic> getPersons(String query, int page);
}