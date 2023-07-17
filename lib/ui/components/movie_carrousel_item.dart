import 'package:FilmFlu/ui/components/movie_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FilmFlu/dto/movie.dart';
import 'package:flutter/material.dart';
import 'package:FilmFlu/network/api.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      InkWell(
        onTap: () => showModalBottomSheet(
          isDismissible: true,
          context: context,
          builder: (context) => MovieItem(movieId: movie.id),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: '$imgBaseUrl${movie.posterPath}',
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
            Text(
              movie.title,
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'LilitaOne'),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    ]);
  }
}
