import 'package:FilmFlu/dto/tv_show.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../network/api.dart';

class TvShowItem extends StatelessWidget {
  const TvShowItem({super.key, required this.tvShow});

  final TvShow tvShow;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CachedNetworkImage(
        imageUrl: '$imgBaseUrl${tvShow.posterPath}',
        placeholder: (context, url) => const CircularProgressIndicator(),
      ),
      Text(
        tvShow.title,
        style: const TextStyle(
          color: Colors.white,
        ),
      )
    ]);
  }
}
