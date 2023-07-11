import 'package:cached_network_image/cached_network_image.dart';
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/env/env.dart';
import 'package:flutter/material.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CachedNetworkImage(
        imageUrl: '${Env.imgBaseURL}${movie.posterPath}',
        placeholder: (context, url) => const CircularProgressIndicator(),
      ),
      Text(movie.title)
    ]);
  }
}
