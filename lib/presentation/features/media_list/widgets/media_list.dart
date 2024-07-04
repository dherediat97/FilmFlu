import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:FilmFlu/presentation/features/media_list/widgets/media_carrousel_item.dart';
import 'package:flutter/material.dart';

class MediaList extends StatelessWidget {
  const MediaList({
    super.key,
    required this.items,
  });

  final List<MediaItemEntity> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return MovieCarrouselItem(movie: items[index]);
        },
      ),
    );
  }
}
