import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/models/genre_entity.dart';
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
            final icon =
                GenreIds.values
                    .firstWhere((element) => element.id == genre.id)
                    .icon;
            return Chip(
              backgroundColor:
                  firstGenre
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
              label: Text(
                genre.name,
                style: TextStyle(
                  color:
                      firstGenre
                          ? AppColors.backgroundColorLight
                          : Theme.of(context).colorScheme.inverseSurface,
                  fontSize: 16,
                ),
              ),
              avatar: Icon(
                icon,
                size: 24,
                color:
                    firstGenre
                        ? AppColors.backgroundColorLight
                        : Theme.of(context).colorScheme.primary,
              ),
            );
          }).toList(),
    );
  }
}
