import 'package:film_flu/domain/models/review_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ReviewsWidgetItem extends StatelessWidget {
  const ReviewsWidgetItem({super.key, required this.review});

  final ReviewEntity review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.network(
                        'https://avatar.iran.liara.run/username?username=${review.author}',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(review.authorDetails.username),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  review.content,
                  textStyle: const TextStyle(fontSize: 14),
                  renderMode: RenderMode.column,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
