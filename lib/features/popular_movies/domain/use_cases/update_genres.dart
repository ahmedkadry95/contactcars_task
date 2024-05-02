import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/features/popular_movies/data/repositories/popular_movies_repositories_impl.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';

class UpdateGenreUseCase {
  final PopularMoviesRepositoriesImpl repository =
      di<PopularMoviesRepositoriesImpl>();

  Future<Either<Failure, List<Genre>>> call() async {
    return await repository.updateGenre();
  }
}
