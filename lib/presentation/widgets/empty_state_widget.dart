import 'package:film_flu/app/constants/app_assets.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: Image.asset(AppAssets.emptyStateImage).image,
            ),
          ),
        ),
        Text(errorMessage, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
