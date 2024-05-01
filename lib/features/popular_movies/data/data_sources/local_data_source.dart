import 'package:contactcars_task/core/services/hive/hive.dart';
import 'package:contactcars_task/features/popular_movies/data/models/movie_model.dart';
import 'package:dartz/dartz.dart';

abstract class PopularMoviesLocalDataSource {
  Future<List<MovieModel>> getCashedPopularMovies({
    required int pageNumber,
  });

  Future<Unit> cashMovies({
    required List<MovieModel> movies,
  });
}

///
/// A class that implements the [PopularMoviesLocalDataSource] abstract class.
///

class LocalDataSourceImpl implements PopularMoviesLocalDataSource {
  @override
  Future<List<MovieModel>> getCashedPopularMovies({
    required int pageNumber,
  }) async {
    int startIndex = (pageNumber - 1) * 20;
    int endIndex = startIndex + 20;
    if (endIndex > popularMoviesBox!.length) {
      endIndex = popularMoviesBox!.length;
    }
    List<MovieModel> movies = [];
    for (int i = startIndex; i < endIndex; i++) {
      var movieJson =
          hiveObjectConvertorToMAp(await popularMoviesBox!.getAt(i));
      MovieModel movie = MovieModel.fromJson(movieJson);
      movies.add(movie);
    }
    return Future.value(movies);
  }

  @override
  Future<Unit> cashMovies({
    required List<MovieModel> movies,
  }) async {
    for (MovieModel movie in movies) {
      bool isExist = popularMoviesBox!.containsKey(movie.id);
      if (!isExist) {
        await popularMoviesBox?.put(
          movie.id,
          movie.toJson(),
        );
      }
    }
    return Future.value(unit);
  }
}

Map<String, dynamic> hiveObjectConvertorToMAp(dynamic hiveObject) {
  Map<String, dynamic> map = {};
  for (var key in hiveObject.keys) {
    map[key.toString()] = hiveObject[key]; // Convert keys to strings
  }
  return map;
}
