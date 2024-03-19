//Core Packages
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/dto/film_worker.dart';
import 'package:FilmFlu/dto/actor.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_api.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/film_worker_cast_item.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/film_actor_cast_item.dart';
import 'package:FilmFlu/core/extensions/loading_extension.dart';
import 'package:FilmFlu/modules/movies/domain/entities/credits.dart';

class FilmCast extends StatefulWidget {
  const FilmCast({
    super.key,
    required this.movieId,
    required this.isCast,
    required this.mediaType,
  });

  final bool isCast;

  final String movieId;
  final String mediaType;

  @override
  State<FilmCast> createState() => _FilmCastState();
}

class _FilmCastState extends State<FilmCast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: FutureBuilder<Credits>(
          future: Api().fetchCredits(widget.movieId, widget.mediaType),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return DefaultWidgetLoading();

            List<Actor>? cast =
                snapshot.requireData.cast?.unique((element) => element.name);
            List<FilmWorker>? crew =
                snapshot.requireData.crew?.unique((element) => element.name);
            return GridView.builder(
              controller: TrackingScrollController(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: 240,
                childAspectRatio: MediaQuery.of(context).size.aspectRatio,
              ),
              itemCount: widget.isCast ? cast?.length : crew?.length,
              itemBuilder: (context, index) => widget.isCast
                  ? FilmActorItem(index: index, cast: cast!)
                  : FilmWorkerItem(index: index, crew: crew!),
            );
          }),
    );
  }
}
