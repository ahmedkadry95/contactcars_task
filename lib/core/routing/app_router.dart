import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/routing/routs.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:contactcars_task/features/popular_movies/presentation/pages/movie_details.dart';
import 'package:contactcars_task/features/popular_movies/presentation/pages/popular_movies.dart';
import 'package:contactcars_task/features/splash/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;
    ;
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const Splash(),
        );
      case Routes.popularMovies:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => di<PopularMoviesCubit>(),
            child: const PopularMovies(),
          ),
        );
      case Routes.movieDetails:
        return MaterialPageRoute(
          builder: (_) => MovieDetails(
            movie: arguments!['movie'] as Movie,
            genre: arguments['genre'] as List<Genre>,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    );
  }
}
