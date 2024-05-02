import 'package:contactcars_task/core/helper_functions/hive_object_convertor_to_map.dart';
import 'package:contactcars_task/core/services/hive/hive.dart';
import 'package:contactcars_task/features/popular_movies/data/models/genre_model.dart';
import 'package:contactcars_task/features/popular_movies/data/models/movie_model.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';

abstract class PopularMoviesLocalDataSource {
  Future<List<MovieModel>> getCashedPopularMovies({
    required int pageNumber,
  });

  Future<Unit> cashMovies({
    required List<MovieModel> movies,
  });

  Future<List<Genre>> getGenres();

  Future<Unit> cashGenres(List<GenresModel> genres);
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
      hiveObjectConvertorToMap(await popularMoviesBox!.getAt(i));
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

  @override
  Future<List<Genre>> getGenres() async {
    List<GenresModel> genres = [];
    for (var element in genresBox!.values) {
      var genreJson = hiveObjectConvertorToMap(element);
      GenresModel genre = GenresModel.fromJson(genreJson);
      genres.add(genre);
    }
    return Future.value(genres);
  }

  @override
  Future<Unit> cashGenres(List<GenresModel> genres) async {
    for (GenresModel genre in genres) {
      bool isExist = genresBox!.containsKey(genre.id);
      if (!isExist) {
        await genresBox?.put(
          genre.id,
          genre.toJson(),
        );
      }
    }
    return Future.value(unit);
  }
}

