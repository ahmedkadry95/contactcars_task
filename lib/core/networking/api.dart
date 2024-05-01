import 'package:contactcars_task/core/networking/exception.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/core/networking/network_checker.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiHelper {
  late final Dio dio;
  NetworkChecker networkChecker =
      NetworkCheckerImpl(connectionChecker: InternetConnectionChecker());

  ApiHelper() {
    dio = Dio();
    dio.options.baseUrl = 'https://api.themoviedb.org/3/movie/';
    dio.options.headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MGRhZmEyNDk3OWEzZTdlYTRlYjQ2NDgzMzFhYzRkYiIsInN1YiI6IjY2MzAwZWYyNjA5NzUwMDEyYmRhZmUxMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-eUkIgQTGm8I5n4rJhs04kAlQSo1jGTl_5uego7cfXI',
      'accept': 'application/json'
    };
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<T> handleDataSourceRequest<T>({
    required Function() onTry,
    required T Function(Response response) onSuccess,
  }) async {
    try {
      final Response response = await onTry();
      if (response.statusCode == 200) {
        return onSuccess(response);
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }

  Future<Either<Failure, T>> handleRepoFunction<T>({
    required Function() onTry,
    required Function() onOffline,
  }) async {
    if (await networkChecker.isConnected) {
      try {
        return Right(await onTry());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await onOffline());
      } on EmptyCashException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
