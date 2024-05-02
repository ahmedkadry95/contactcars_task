import 'package:bloc/bloc.dart';
import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/core/networking/network_checker.dart';
import 'package:contactcars_task/core/routing/navigation.dart';
import 'package:contactcars_task/core/routing/routs.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/domain/use_cases/get_genres.dart';
import 'package:contactcars_task/features/popular_movies/domain/use_cases/get_popular_movies_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit() : super(PopularMoviesLoading());
  NetworkChecker networkChecker =
      NetworkCheckerImpl(connectionChecker: InternetConnectionChecker());

  GetPopularMoviesUseCase getPopularMoviesUseCase =
      di<GetPopularMoviesUseCase>();
  GetGenreUseCase getGenreUseCase = di<GetGenreUseCase>();

  late List<Genre> genres;
  int pageNumber = 0;

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
      (movies) async {
        isNext ? this.pageNumber++ : this.pageNumber--;
        await getGenres();
        emit(PopularMoviesLoadedSuccessfully(movies: movies));
      },
    );
  }

  checkInternetConnection(BuildContext context) async {
    if (await networkChecker.isConnected) {
      getPopularMovies(
        pageNumber: pageNumber == 0 ? 1 : pageNumber,
        isNext: true,
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No internet connection!'),
        ));
      }
    }
  }

  getGenres() async {
    var response = await getGenreUseCase.call();
    response.fold(
      (failure) {
        emit(PopularMoviesLoadedFailed(message: getErrorMessage(failure)));
      },
      (genres) {
        this.genres = genres;
      },
    );
  }

  List<Genre> getMovieGenres({required List<int> genreIds}) {
    print('genreIds');
    print(genreIds);
    List<Genre> genre = [];
    for (var element in genreIds) {
      genre.add(genres.where((element2) => element2.id == element).first);
    }
    return genre;
  }

  navigateToMovieDetailsPage({
    required BuildContext context,
    required Movie movie,
  }) {

    context.pushWithNamed(
      Routes.movieDetails,
      arguments: {
        'movie': movie,
        'genre': getMovieGenres(genreIds: movie.genreIds),
      },
    );
  }
}
