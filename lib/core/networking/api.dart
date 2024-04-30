import 'package:contactcars_task/core/networking/exception.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

String errorMessage = '';

class ApiHelper {
  late final Dio dio;

  ApiHelper() {
    dio = Dio();
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
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return onSuccess(response);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        throw ValidationException();
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }

  static Future<Either<Failure, T>> handleRepoFunction<T>({
    required Function() onTry,
  }) async {
    try {
      return Right(await onTry());
    } on ValidationException {
      return Left(ValidationFailure());
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
