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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MovieDetailsPage(
                          movieId: movie.id,
                          isTrailerSelected: false,
                          isFilm: movie.title != null,
                        )));
              },
              child: Container(
                width: 250,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      '$movieImgBaseURL${movie.backdropPath}',
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
              )),
          AutoSizeText(movie.title == null ? movie.name! : movie.title!,
              maxLines: 2,
              maxFontSize: 15,
              minFontSize: 13,
              stepGranularity: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
