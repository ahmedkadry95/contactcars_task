import 'package:bloc/bloc.dart';
import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/networking/failure.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/domain/use_cases/get_popular_movies_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit() : super(PopularMoviesLoading());
  GetPopularMoviesUseCase getPopularMoviesUseCase =
      di<GetPopularMoviesUseCase>();

  getPopularMovies({required int pageNumber}) async {
    var response = await getPopularMoviesUseCase.call(pageNumber: pageNumber);
    response.fold(
      (failure) {
        if (failure is EmptyCacheFailure) {
          emit(NoCashedPopularMoviesExist());
        } else {
          emit(PopularMoviesLoadedFailed(message: getErrorMessage(failure)));
        }
      },
      (movies) {
        emit(PopularMoviesLoadedSuccessfully(movies: movies));
      },
    );
  }
}
