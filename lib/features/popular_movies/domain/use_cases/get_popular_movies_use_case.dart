import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/domain/repositories/popular_movies_repositories.dart';
import 'package:dartz/dartz.dart';

class GetPopularMoviesUseCase {
  final PopularMoviesRepositories repository;

  GetPopularMoviesUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> call({
    required int page,
  }) async {
    return await repository.getPopularMovies(page: page);
  }
}
