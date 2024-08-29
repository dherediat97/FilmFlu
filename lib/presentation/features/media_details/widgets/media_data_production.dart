import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/film_worker_item.dart';
import 'package:flutter/material.dart';

class MediaDataProduction extends StatelessWidget {
  const MediaDataProduction({
    super.key,
    required this.crew,
  });

  final List<FilmWorkerEntity> crew;

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
        childCount: crew.length,
        (_, index) {
          FilmWorkerEntity? filmWorker = crew[index];

          return FilmWorkerItem(
            filmWorker: filmWorker,
          );
        },
      ),
    );
  }
}
