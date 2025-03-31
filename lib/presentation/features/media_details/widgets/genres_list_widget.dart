import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/genre_chip.dart';
import 'package:flutter/material.dart';

class GenresListWidget extends StatefulWidget {
  const GenresListWidget({super.key, required this.genres});
  final List<GenreEntity> genres;

  @override
  State<GenresListWidget> createState() => _GenresListWidgetState();
}

class _GenresListWidgetState extends State<GenresListWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          List<Widget>.generate(widget.genres.length, (int index) {
            final firstGenre = index == 0;
            final genre = widget.genres[index];
            return GenreChip(genre: genre, firstGenre: firstGenre);
          }).toList(),
    );
  }
}
