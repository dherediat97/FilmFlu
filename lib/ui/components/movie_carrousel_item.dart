import 'package:FilmFlu/ui/components/fast_movie_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FilmFlu/dto/movie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:FilmFlu/network/api.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final Movie movie;

  final boxFit = kIsWeb ? BoxFit.fitWidth : BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            showDragHandle: true,
            enableDrag: true,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height / 2),
            isDismissible: true,
            context: context,
            builder: (context) => DraggableScrollableSheet(
              expand: false,
              initialChildSize: 1.0,
              maxChildSize: 1.0,
              minChildSize: 0.0,
              builder: (context, scrollController) => SingleChildScrollView(
                controller: scrollController,
                child: FastMovieDetails(movieId: movie.id),
              ),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.all(0),
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  fit: boxFit,
                  image: CachedNetworkImageProvider(
                      '$movieImgBaseURL${movie.posterPath}'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
