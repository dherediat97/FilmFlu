import 'package:FilmFlu/dto/tv_show.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FilmFlu/env/env.dart';
import 'package:flutter/material.dart';

class TvShowItem extends StatelessWidget {
  const TvShowItem({super.key, required this.tvShow});

  final TvShow tvShow;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CachedNetworkImage(
        imageUrl: '${Env.imgBaseURL}${tvShow.posterPath}',
        placeholder: (context, url) => const CircularProgressIndicator(),
      ),
      Text(
        tvShow.title,
        style: TextStyle(
          color: Colors.white,
        ),
      )
    ]);
  }
}
