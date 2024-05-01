import 'package:bloc/bloc.dart';
import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/core/networking/network_checker.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/domain/use_cases/get_popular_movies_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit() : super(PopularMoviesLoading());
  int pageNumber = 0;
  GetPopularMoviesUseCase getPopularMoviesUseCase =
      di<GetPopularMoviesUseCase>();
  NetworkChecker networkChecker =
      NetworkCheckerImpl(connectionChecker: InternetConnectionChecker());

  getPopularMovies({
    required int pageNumber,
    bool isNext = true,
  }) async {
    emit(PopularMoviesLoading());
    var response = await getPopularMoviesUseCase.call(
      pageNumber: pageNumber,
      isNext: isNext,
    );
    response.fold(
      (failure) {
        if (failure is EmptyCacheFailure) {
          emit(NoCashedPopularMoviesExist(message: getErrorMessage(failure)));
        } else {
          emit(PopularMoviesLoadedFailed(message: getErrorMessage(failure)));
        }
      },
      (movies) {
        isNext ? this.pageNumber++ : this.pageNumber--;

        emit(PopularMoviesLoadedSuccessfully(movies: movies));
      },
    );
  }

  checkInternetConnection(BuildContext context) async {
    if (await networkChecker.isConnected) {
      getPopularMovies(pageNumber: pageNumber, isNext: true);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No internet connection!'),
        ));
      }
    }
  }
}
