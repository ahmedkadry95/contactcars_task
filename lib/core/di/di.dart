import 'package:contactcars_task/core/networking/api.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;

Future<void> setupDependencyInjection() async {
  di.registerSingleton<ApiHelper>(ApiHelper());
  di.registerSingleton<PopularMoviesCubit>(PopularMoviesCubit());
}
