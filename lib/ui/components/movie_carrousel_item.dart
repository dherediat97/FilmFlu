import 'package:FilmFlu/ui/components/movie_item.dart';
import 'package:FilmFlu/ui/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FilmFlu/dto/movie.dart';
import 'package:flutter/material.dart';
import 'package:FilmFlu/network/api.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isDismissible: true,
            context: context,
            builder: (context) => MovieItem(movieId: movie.id));
      },
      child:
          // Column(children: [
          Card(
              margin: EdgeInsets.all(8),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: CachedNetworkImageProvider(
                            '$movieImgBaseURL${movie.posterPath}'))),
              )),
      // Text(
      //   movie.title,
      //   style: TextStyle(color: primaryColor, fontFamily: 'LilitaOne'),
      //   textAlign: TextAlign.center,
      // ),
      // ]),
    );
  }
}
