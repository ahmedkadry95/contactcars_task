import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/api.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/local_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/remote_data_source.dart';
// import 'package:contactcars_task/features/popular_movies/data/data_sources/remote_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/models/movie_model.dart';
import 'package:contactcars_task/features/popular_movies/domain/repositories/popular_movies_repositories.dart';
import 'package:dartz/dartz.dart';

class PopularMoviesRepositoriesImpl implements PopularMoviesRepositories {
  final RemoteDataSourceImpl remoteDataSourceImpl = di<RemoteDataSourceImpl>();
  final LocalDataSourceImpl localDataSource = di<LocalDataSourceImpl>();

  ApiHelper apiHelper = di<ApiHelper>();

  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies({
    required int pageNumber,
  }) async {
    return await apiHelper.handleRepoFunction(
      onTry: () =>
          remoteDataSourceImpl.getPopularMovies(pageNumber: pageNumber),
      onOffline: () =>
          localDataSource.getCashedPopularMovies(pageNumber: pageNumber),
    );
  }
}
