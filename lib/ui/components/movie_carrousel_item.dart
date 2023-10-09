//Core Packages
import 'package:FilmFlu/ui/util/extension.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/dto/media_item.dart';
import 'package:FilmFlu/constants.dart';
import 'package:FilmFlu/ui/pages/movieDetails/movie_details.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final MediaItem movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MovieDetailsPage(
                    movieId: movie.id,
                    isTrailerSelected: false,
                    isFilm: movie.title != null,
                  ),
                ),
              );
            },
            child: Container(
              width: 220,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: Image.network(
                    '$movieImgBaseURL${movie.posterPath}',
                    loadingBuilder: (context, child, loadingProgress) =>
                        DefaultAsyncLoading(
                      child: child,
                      loadingProgress: loadingProgress,
                    ),
                  ).image,
                ),
              ),
            ),
          ),
          // SizedBox(height: 10),
          // SizedBox(
          //   width: 200,
          //   height: 31,
          //   child: AutoSizeText(
          //     movie.title != null ? movie.title! : movie.name!,
          //     maxFontSize: 24,
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
