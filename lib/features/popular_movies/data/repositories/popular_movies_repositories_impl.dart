import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/api.dart';
import 'package:contactcars_task/core/networking/exception.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/core/networking/network_checker.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/local_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/remote_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/models/movie_model.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
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
    try {
      // Try to get movies from local database first
      final movies = await localDataSource.getCashedPopularMovies(
        pageNumber: pageNumber,
      );

      // If local database is empty and network is connected, fetch from server
      if (movies.isEmpty && await networkChecker.isConnected & isNext) {
        try {
          final moviesFromServer = await remoteDataSourceImpl.getPopularMovies(
              pageNumber: pageNumber);
          await localDataSource.cashMovies(
            movies: moviesFromServer,
          );
          return Right(moviesFromServer);
        } on ServerException {
          return Left(ServerFailure());
        }
      }

      // If local database is not empty, return the movies
      if (movies.isNotEmpty) {
        return Right(movies);
      }

      // If local database is empty and network is not connected, return failure
      return Left(EmptyCacheFailure());
    } on EmptyCashException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Genre>>> getGenre() async {
    try {
      // Try to get genres from local database first
      final genres = await localDataSource.getGenres();

      // If local database is empty and network is connected, fetch from server
      if (genres.isEmpty && await networkChecker.isConnected) {
        try {
          final genresFromServer = await remoteDataSourceImpl.getGenre();
          await localDataSource.cashGenres(genresFromServer);
          return Right(genresFromServer);
        } on ServerException {
          return Left(ServerFailure());
        }
      }

      // If local database is not empty, return the genres
      if (genres.isNotEmpty) {
        return Right(genres);
      }

      // If local database is empty and network is not connected, return failure
      return Left(EmptyCacheFailure());
    } on EmptyCashException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Genre>>> updateGenre() async {
    try {
      // Fetch genres from server
      final genresFromServer = await remoteDataSourceImpl.getGenre();

      // Cache the fetched genres in local database
      await localDataSource.cashGenres(genresFromServer);

      // Return the updated genres
      return Right(genresFromServer);
    } on ServerException {
      // If there's a server exception, return a ServerFailure
      return Left(ServerFailure());
    } catch (e) {
      // If there's any other exception, return a ServerFailure
      return Left(ServerFailure());
    }
  }
}
