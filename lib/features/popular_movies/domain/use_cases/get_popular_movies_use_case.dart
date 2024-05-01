import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/features/popular_movies/data/repositories/popular_movies_repositories_impl.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';

class GetPopularMoviesUseCase {
  final PopularMoviesRepositoriesImpl repository =
      di<PopularMoviesRepositoriesImpl>();

  Future<Either<Failure, List<Movie>>> call({
    required int pageNumber,
  }) async {
    return await repository.getPopularMovies(
      pageNumber: pageNumber,

    );
  }
}
