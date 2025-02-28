import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/actor_worker_item.dart';
import 'package:flutter/material.dart';

class MediaDataCast extends StatefulWidget {
  const MediaDataCast({
    super.key,
    required this.cast,
  });

  final List<ActorEntity> cast;

  @override
  State<MediaDataCast> createState() => _MediaDataCastState();
}

class _MediaDataCastState extends State<MediaDataCast> {
  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 300,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: widget.cast.length,
        (_, index) {
          ActorEntity? actor = widget.cast[index];

          return FilmActorItem(
            actor: actor,
          );
        },
      ),
    );
  }
}
