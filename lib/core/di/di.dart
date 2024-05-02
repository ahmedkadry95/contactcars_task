import 'package:contactcars_task/core/networking/api.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/local_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/data_sources/remote_data_source.dart';
import 'package:contactcars_task/features/popular_movies/data/repositories/popular_movies_repositories_impl.dart';
import 'package:contactcars_task/features/popular_movies/domain/use_cases/get_genres.dart';
import 'package:contactcars_task/features/popular_movies/domain/use_cases/get_popular_movies_use_case.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;

Future<void> setupDependencyInjection() async {
  /// networking
  di.registerSingleton<ApiHelper>(ApiHelper());

  ////////////////////////////////////////////////////////////////
  ///////////////////////    popular Movies    ///////////////////
  ////////////////////////////////////////////////////////////////

  /// popular movies data sources
  di.registerSingleton<RemoteDataSourceImpl>(RemoteDataSourceImpl());
  di.registerSingleton<LocalDataSourceImpl>(LocalDataSourceImpl());

  /// popular movies repositories
  di.registerSingleton<PopularMoviesRepositoriesImpl>(
      PopularMoviesRepositoriesImpl());

  /// popular movies use cases
  di.registerSingleton<GetPopularMoviesUseCase>(GetPopularMoviesUseCase());
  di.registerSingleton<GetGenreUseCase>(GetGenreUseCase());

  /// popular movies cubit
  di.registerSingleton<PopularMoviesCubit>(PopularMoviesCubit());

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
}
