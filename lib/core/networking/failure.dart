import 'package:contactcars_task/core/constants/strings/constant_strings.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// No internet connection
class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// Server Error (api doesn't return data from server)
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// Empty cash exception
class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// getErrorMessage method to get the error message based on the failure type
String getErrorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case const (ServerFailure):
      return AppStrings.serverFailure;
    case const (OfflineFailure):
      return AppStrings.offlineFailure;
    case const (EmptyCacheFailure):
      return AppStrings.emptyCacheFailure;
    default:
      return AppStrings.unExpectedError;
  }
}
