//Core Packages
import 'package:auto_size_text/auto_size_text.dart';
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
              width: 240,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(62.0),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.network(
                    '$movieImgBaseURL${movie.posterPath}',
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
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
