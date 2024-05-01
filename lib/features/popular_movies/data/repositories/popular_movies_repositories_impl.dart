import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/api.dart';
import 'package:contactcars_task/core/networking/exception.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/core/networking/network_checker.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/local_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/remote_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/models/movie_model.dart';
import 'package:contactcars_task/features/popular_movies/domain/repositories/popular_movies_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PopularMoviesRepositoriesImpl implements PopularMoviesRepositories {
  final RemoteDataSourceImpl remoteDataSourceImpl = di<RemoteDataSourceImpl>();
  final LocalDataSourceImpl localDataSource = di<LocalDataSourceImpl>();
  ApiHelper apiHelper = di<ApiHelper>();
  NetworkChecker networkChecker =
      NetworkCheckerImpl(connectionChecker: InternetConnectionChecker());

  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies({
    required int pageNumber,
    required bool isNext,
  }) async {
    if (await networkChecker.isConnected & isNext) {
      try {
        final movies =
            await remoteDataSourceImpl.getPopularMovies(pageNumber: pageNumber);
        await localDataSource.cashMovies(
          movies: movies,
        );
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final movies = await localDataSource.getCashedPopularMovies(
          pageNumber: pageNumber,
        );
        if (movies.isEmpty) {
          return Left(EmptyCacheFailure());
        }
        return Right(movies);
      } on EmptyCashException {
        return Left(EmptyCacheFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    }
  }
}
