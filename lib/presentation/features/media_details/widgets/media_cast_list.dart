import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/actor_worker_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/film_worker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmCast extends StatefulWidget {
  const FilmCast({
    super.key,
    required this.genres,
    required this.movieId,
    required this.isCast,
    required this.mediaType,
    required this.cast,
    required this.crew,
  });

  final bool isCast;

  final String movieId;
  final String mediaType;

  final List<GenreEntity>? genres;
  final List<ActorEntity>? cast;
  final List<FilmWorkerEntity>? crew;

  @override
  State<FilmCast> createState() => _FilmCastState();
}

class _FilmCastState extends State<FilmCast> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        return widget.cast != null && widget.crew != null
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 280,
                      mainAxisExtent: 240,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                    ),
                    itemCount: widget.isCast
                        ? widget.cast?.length
                        : widget.crew?.length,
                    itemBuilder: (context, index) => widget.isCast
                        ? FilmActorItem(
                            index: index,
                            cast: widget.cast!,
                            mainGenre: widget.genres!.first,
                          )
                        : FilmWorkerItem(
                            index: index,
                            crew: widget.crew!,
                            mainGenre: widget.genres!.first,
                          ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
