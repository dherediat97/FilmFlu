//Core Packages
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

//My Packages
import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/core/extensions/loading_extension.dart';

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
                Modular.to.pushReplacementNamed("/movieDetails/${movie.id}");
              },
              child: SizedBox(
                width: 250,
                height: 220,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
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
            ),
          ],
        ));
  }
}
