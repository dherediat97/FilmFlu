import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ReviewsWidgetItem extends StatelessWidget {
  const ReviewsWidgetItem({super.key, required this.review});

  final ReviewEntity review;

  @override
  Widget build(BuildContext context) {
    bool reviewTooLarge = review.content.length > 1000;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.network(
                  '${AppUrls.profileImgBaseUrl}${review.author}',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(review.authorDetails.username),
              subtitle: HtmlWidget(
                reviewTooLarge
                    ? '${review.content.substring(0, 1000)}...'
                    : review.content,
                textStyle: const TextStyle(fontSize: 14),
                renderMode: RenderMode.column,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
