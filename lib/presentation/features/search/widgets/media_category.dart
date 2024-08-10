import 'package:flutter/material.dart';

class MediaCategory extends StatelessWidget {
  const MediaCategory({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
  });

  final String categoryName;
  final IconData categoryIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              trailing: Icon(categoryIcon),
              title: Text(
                categoryName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
