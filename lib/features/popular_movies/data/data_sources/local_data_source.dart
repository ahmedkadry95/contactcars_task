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
    int endIndex = pageNumber + 10;
    if (endIndex > popularMoviesBox!.length) {
      endIndex = popularMoviesBox!.length;
    }
    List<MovieModel> movies = [];
    for (int i = pageNumber; i < endIndex; i++) {
      MovieModel movie = await popularMoviesBox!.getAt(i);
      movies.add(movie);
    }
    return Future.value(movies);
  }

  @override
  Future<Unit> cashMovies({
    required List<MovieModel> movies,
  }) async {
    await popularMoviesBox
        ?.addAll(movies.map((movie) => movie.toJson()).toList());
    return Future.value(unit);
  }
}
