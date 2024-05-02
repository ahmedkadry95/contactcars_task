import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';

abstract class PopularMoviesRepositories {
  Future<Either<Failure, List<Movie>>> getPopularMovies({
    required int pageNumber,
    required bool isNext,
  });

  Future<Either<Failure, List<Genre>>> getGenre();
}
