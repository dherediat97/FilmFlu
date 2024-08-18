import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/actor_worker_item.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class MediaDataCast extends StatelessWidget {
  const MediaDataCast({
    super.key,
    required this.cast,
  });

  final List<ActorEntity>? cast;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: cast == null,
      child: GridView.custom(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 300,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: cast?.length,
          (_, index) {
            ActorEntity? actor = cast?[index];

            return FilmActorItem(
              actor: actor,
            );
          },
        ),
      ),
    );
  }
}
