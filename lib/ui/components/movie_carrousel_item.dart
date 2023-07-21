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
        onTap: () {
          showModalBottomSheet(
              isDismissible: true,
              context: context,
              builder: (context) => MovieItem(movieId: movie.id));
        },
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: '$movieImgBaseURL${movie.posterPath}',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontFamily: 'LilitaOne'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )),
      )
    ]);
  }
}
