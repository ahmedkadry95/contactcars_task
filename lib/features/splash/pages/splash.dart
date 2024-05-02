import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:contactcars_task/core/routing/routs.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:contactcars_task/features/popular_movies/presentation/pages/popular_movies.dart';
import 'package:contactcars_task/features/splash/widgets/splash_logo.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: ColorsManager.mainColor,
        duration: 2500,
        splashIconSize: double.infinity,
        animationDuration: const Duration(milliseconds: 1500),
        splashTransition: SplashTransition.slideTransition,
        curve: Curves.easeInOut,
        nextRoute: Routes.popularMovies,
        splash: const SplashLogo(),
        nextScreen: PopularMovies(),
        // nextScreen: _getNextScreen(),
      ),
    );
  }
}
