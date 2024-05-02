import 'package:contactcars_task/core/shaerd_widgets/app_cashed_image.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:contactcars_task/core/utilis/media_query/media_query.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.38,
      child: Stack(
        children: [
          AppCashedImage(
            height: context.height * 0.3,
            width: context.width,
            imageUrl: movie.backdropPath,
          ),
          Positioned(
            top: context.height * 0.05,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              child: Hero(
                tag: 'poster${movie.id}',
                child: AppCashedImage(
                  width: context.width * 0.35,
                  height: context.height * 0.30,
                  imageUrl: movie.posterPath,
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 20,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.arrow_back),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
