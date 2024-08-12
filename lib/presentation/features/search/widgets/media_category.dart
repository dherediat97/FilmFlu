import 'package:flutter/material.dart';

class MediaCategory extends StatelessWidget {
  const MediaCategory({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
    this.onItemClick,
  });

  final String categoryName;
  final IconData categoryIcon;
  final Function()? onItemClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            onTap: () => onItemClick,
            trailing: Icon(categoryIcon),
            title: Text(
              categoryName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
