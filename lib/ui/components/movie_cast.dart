//Core Packages
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/dto/credits.dart';
import 'package:FilmFlu/dto/film_worker.dart';
import 'package:FilmFlu/dto/actor.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/ui/components/film_worker_cast_item.dart';
import 'package:FilmFlu/ui/components/film_actor_cast_item.dart';

class FilmCast extends StatefulWidget {
  const FilmCast({super.key, required this.movieId, required this.isCast});

  final bool isCast;

  final int movieId;

  @override
  State<FilmCast> createState() => _FilmCastState();
}

class _FilmCastState extends State<FilmCast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: FutureBuilder<Credits>(
          future: Api().fetchCredits(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()));
            }
            final List<Actor>? cast = snapshot.requireData.cast;
            final List<FilmWorker>? crew = snapshot.requireData.crew;
            return GridView.builder(
              controller: TrackingScrollController(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 0,
                crossAxisSpacing: 40,
                mainAxisExtent: 340,
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
