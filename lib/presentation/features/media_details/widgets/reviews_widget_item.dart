import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/widgets/default_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ReviewsWidgetItem extends StatelessWidget {
  const ReviewsWidgetItem({
    super.key,
    required this.review,
  });

  final ReviewEntity review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.network(
                  '${AppUrls.profileImgBaseUrl}${review.authorDetails.avatarPath}',
                  height: 80,
                  width: 60,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) =>
                      DefaultImageLoader(progress: progress, child: child),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(review.author),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  review.content,
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
