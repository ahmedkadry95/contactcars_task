import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/api.dart';
import 'package:contactcars_task/features/popular_movies/data/models/genre_model.dart';
import 'package:contactcars_task/features/popular_movies/data/models/movie_model.dart';

abstract class PopularMoviesRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies({
    required int pageNumber,
  });

  Future<List<GenresModel>> getGenre();
}

/// A class that implements the [PopularMoviesRemoteDataSource] abstract class.

class RemoteDataSourceImpl implements PopularMoviesRemoteDataSource {
  ApiHelper apiHelper = di<ApiHelper>();

  @override
  Future<List<MovieModel>> getPopularMovies({
    required int pageNumber,
  }) async {
    return await apiHelper.handleDataSourceRequest(
      onTry: () =>
          apiHelper.dio.get('movie/popular?language=en-US&page=$pageNumber'),
      onSuccess: (response) => (response.data['results'] as List)
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList(),
    );
  }

  @override
  Future<List<GenresModel>> getGenre() async {
    return await apiHelper.handleDataSourceRequest(
      onTry: () => apiHelper.dio.get('genre/movie/list?language=en'),
      onSuccess: (response) => (response.data['genres'] as List)
          .map<GenresModel>((json) => GenresModel.fromJson(json))
          .toList(),
    );
  }
}
