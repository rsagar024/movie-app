import 'package:movie_app/core/models/cast_info_model.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/network/i_network_service.dart';
import 'package:movie_app/core/network/network_service_impl.dart';

class CastRepository{
  final INetworkService _service = NetworkServiceImpl();

  Future<List<dynamic>> getCastDetails(String id) async {
    CastPersonalInfo castInfo;
    SocialMediaInfo socialMedia;
    ImageBackdropList backdrops;
    MovieModelList movies;

    var response = await _service.getCastDetails(id);

    castInfo = CastPersonalInfo.fromJson(response['data']);
    socialMedia = SocialMediaInfo.fromJson(response['socialmedia']);
    backdrops = ImageBackdropList.fromJson(response['images']['profiles']);
    movies = MovieModelList.fromJson(response['movies']['cast']);

    return [
      castInfo,
      socialMedia,
      backdrops.backdrops,
      movies.movies,
    ];
  }
}