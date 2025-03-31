import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:flutter/material.dart';

class GenreChip extends StatefulWidget {
  const GenreChip({super.key, required this.genre, required this.firstGenre});

  final bool firstGenre;
  final GenreEntity genre;

  @override
  State<GenreChip> createState() => _GenreChipState();
}

class _GenreChipState extends State<GenreChip> {
  @override
  Widget build(BuildContext context) {
    final icon =
        GenreIds.values
            .firstWhere((element) => element.id == widget.genre.id)
            .icon;
    return Chip(
      padding: EdgeInsets.all(8.0),
      backgroundColor:
          widget.firstGenre
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
      label: Text(
        widget.genre.name,
        style: TextStyle(
          color:
              widget.firstGenre
                  ? AppColors.backgroundColorLight
                  : Theme.of(context).colorScheme.inverseSurface,
          fontSize: 16,
        ),
      ),
      avatar: Icon(
        icon,
        fill: 1.0,
        size: 24,
        color:
            widget.firstGenre
                ? AppColors.backgroundColorLight
                : Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
