import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesRepositories {
  Future<Either<Failure, List<Movie>>> getPopularMovies();
}