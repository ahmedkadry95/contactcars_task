part of 'popular_movies_cubit.dart';

@immutable
abstract class PopularMoviesState extends Equatable {}

/// this state will be emitted initially & when for loading data
class PopularMoviesLoading extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

/// this state will be emitted when data loaded successfully
class PopularMoviesLoadedSuccessfully extends PopularMoviesState {
  final List<Movie> movies;

  PopularMoviesLoadedSuccessfully({required this.movies});

  @override
  // TODO: implement props
  List<Object?> get props => movies;
}

/// this state will be emitted when data loaded failed
class PopularMoviesLoadedFailed extends PopularMoviesState {
  final String message;

  PopularMoviesLoadedFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

/// this state will be emitted when data loaded failed
class NoCashedPopularMoviesExist extends PopularMoviesState {
  final String message;

  NoCashedPopularMoviesExist({required this.message});
  @override
  List<Object?> get props => [];
}
