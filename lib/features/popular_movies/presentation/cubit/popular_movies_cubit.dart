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
import 'package:contactcars_task/features/popular_movies/domain/use_cases/update_genres.dart';
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
  UpdateGenreUseCase updateGenreUseCase = di<UpdateGenreUseCase>();
  GetGenreUseCase getGenreUseCase = di<GetGenreUseCase>();

  late List<Genre> genres;
  bool disableScreen = false;
  int selectedMovieIndex = 0;
  int pageNumber = 0;

  // get popular movies
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

  // update genres list
  updateGenres(
    BuildContext context, {
    required List<Movie> movies,
  }) async {
    var response = await updateGenreUseCase.call();
    response.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Try again later!'),
        ));
      },
      (genres) {
        this.genres = genres;
        emit(PopularMoviesLoadedSuccessfully(movies: movies));
        navigateToMovieDetailsPage(
          context: context,
          movie: movies[selectedMovieIndex],
          genres: genres,
        );
      },
    );
  }

  // check if all genres exist in the genres list
  checkMovieGenres({
    required List<int> genreIds,
    required BuildContext context,
    required List<Movie> movies,
  }) async {
    disableScreen = true;
    emit(UpdateGenres(movies: movies));
    List<Genre> genres = [];
    bool isAllGenresExist = true;
    // check if all genres exist in the genres list
    for (var id in genreIds) {
      try {
        genres.add(genres.firstWhere((element) => element.id == id));
      } catch (e) {
        isAllGenresExist = false;
      }
    }
    // if not all genres exist, update genres
    if (!isAllGenresExist) {
      await updateGenres(context, movies: movies);
    } else {
      navigateToMovieDetailsPage(
        context: context,
        movie: movies[selectedMovieIndex],
        genres: genres,
      ); // if all genres exist, navigate to movie details page
    }
  }

  navigateToMovieDetailsPage({
    required BuildContext context,
    required Movie movie,
    required List<Genre> genres,
  }) {
    context.pushWithNamed(
      Routes.movieDetails,
      arguments: {
        'movie': movie,
        'genre': genres,
      },
    );
  }
}
