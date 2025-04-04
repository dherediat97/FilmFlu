import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.errorMessage,
    required this.urlImage,
  });

  final String errorMessage;
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: Image.asset(urlImage).image,
            ),
          ),
        ),
        Text(errorMessage, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
