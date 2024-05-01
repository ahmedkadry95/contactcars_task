import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/api.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/core/networking/network_checker.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/local_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/remote_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/models/movie_model.dart';
import 'package:contactcars_task/features/popular_movies/domain/repositories/popular_movies_repositories.dart';
import 'package:dartz/dartz.dart';

class PopularMoviesRepositoriesImpl implements PopularMoviesRepositories {
  final PopularMoviesRemoteDataSource remoteDataSource;
  final PopularMoviesLocalDataSource localDataSource;
  final NetworkChecker networkChecker;
  ApiHelper apiHelper = di<ApiHelper>();

  PopularMoviesRepositoriesImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkChecker,
  });

  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies({
    required int page,
  }) async {
    return await apiHelper.handleRepoFunction(
      onTry: () => remoteDataSource.getPopularMovies(page: page),
      onOffline: () => localDataSource.getCashedPopularMovies(startIndex: page),
    );
// TODO: implement check later
    // if (await networkChecker.isConnected) {
    //   try {
    //     final movies = await remoteDataSource.getPopularMovies(page: page);
    //     localDataSource.cashMovies(movies: movies);
    //     return Right(movies);
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   try {
    //     final movies = await localDataSource.getCashedPopularMovies();
    //     return Right(movies);
    //   } on EmptyCashException {
    //     return Left(EmptyCacheFailure());
    //   }
    // }
  }
}
