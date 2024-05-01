import 'package:cached_network_image/cached_network_image.dart';
import 'package:contactcars_task/core/constants/strings/constant_strings.dart';
import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/theming/buttons_styles.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:contactcars_task/core/theming/styles.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({super.key});

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  late PopularMoviesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = di<PopularMoviesCubit>();
    cubit.getPopularMovies(pageNumber: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularMoviesLoadedSuccessfully) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: state.movies[index]);
                    },
                  ),
                ),
                PopularMoviesButtons(cubit: cubit)
              ],
            );
          } else if (state is PopularMoviesLoadedFailed) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else if (state is NoCashedPopularMoviesExist) {
            return Center(
              child: Text(
                state.message,
                style: TextStyles.font22BoldSecondaryAppColor,
                textAlign: TextAlign.center,
              ),
            );
          }
          return const Center(
            child: Text('Something went wrong!'),
          );
        },
      ),
    );
  }
}

////////////////////////////    Popular Movies Buttons          ////////////////////////////
////////////////////////////    Popular Movies Buttons          ////////////////////////////
////////////////////////////    Popular Movies Buttons          ////////////////////////////
////////////////////////////    Popular Movies Buttons          ////////////////////////////

class PopularMoviesButtons extends StatelessWidget {
  const PopularMoviesButtons({
    super.key,
    required this.cubit,
  });

  final PopularMoviesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (cubit.pageNumber > 1)
            ElevatedButton(
              style: mainAppButtonStyle,
              onPressed: () {
                cubit.getPopularMovies(
                  pageNumber: cubit.pageNumber - 1,
                  isNext: false,
                );
              },
              child: const Text('Previous'),
            ),
          ElevatedButton(
            style: mainAppButtonStyle,
            onPressed: () {
              cubit.getPopularMovies(
                pageNumber: cubit.pageNumber + 1,
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

////////////////////////////        MovieCard        ////////////////////////////
////////////////////////////        MovieCard        ////////////////////////////
////////////////////////////        MovieCard        ////////////////////////////
////////////////////////////        MovieCard        ////////////////////////////

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsManager.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 100.sp,
            height: 120.sp,
            imageUrl: AppStrings.imageBaseUrl + movie.posterPath,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => SizedBox(
              width: 100.sp,
              height: 120.sp,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => SizedBox(
              width: 100.sp,
              height: 120.sp,
              child: const Center(child: Icon(Icons.error)),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                movie.title,
                style: TextStyles.font20BoldSecondaryAppColor,
              ),
              subtitle: Text(
                movie.releaseDate,
              ),
              trailing: CircularPercentIndicator(
                radius: 15.0,
                lineWidth: 2.0,
                percent: movie.voteAverage / 10,
                center: Text(
                  '${(movie.voteAverage / 10 * 100).round()}',
                ),
                progressColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
