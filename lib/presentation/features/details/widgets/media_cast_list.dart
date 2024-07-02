import 'package:FilmFlu/app/extensions/custom_loading.dart';
import 'package:FilmFlu/domain/models/actor_entity.dart';
import 'package:FilmFlu/domain/models/film_worker_entity.dart';
import 'package:FilmFlu/presentation/features/details/bloc/media_detail_bloc.dart';
import 'package:FilmFlu/presentation/features/details/widgets/actor_worker_item.dart';
import 'package:FilmFlu/presentation/features/details/widgets/film_worker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        List<ActorEntity>? cast = state.credits?.cast;

        List<FilmWorkerEntity>? crew = state.credits?.crew;

        return cast != null && crew != null
            ? Container(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  controller: TrackingScrollController(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    mainAxisExtent: 240,
                    childAspectRatio: MediaQuery.of(context).size.aspectRatio,
                  ),
                  itemCount: widget.isCast ? cast.length : crew.length,
                  itemBuilder: (context, index) => widget.isCast
                      ? FilmActorItem(index: index, cast: cast)
                      : FilmWorkerItem(index: index, crew: crew),
                ),
              )
            : Container();
      },
    );
  }
}
