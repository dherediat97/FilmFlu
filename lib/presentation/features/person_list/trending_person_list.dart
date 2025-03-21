import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/time_window.dart';
import 'package:film_flu/presentation/features/person_list/widgets/person_list.dart';
import 'package:flutter/material.dart';

class TrendingPersonListWidget extends StatelessWidget {
  const TrendingPersonListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          PersonListWidget(
            title: context.localizations.trending_person_day,
            timeWindow: TimeWindow.day,
          ),
          PersonListWidget(
            title: context.localizations.trending_person_week,
            timeWindow: TimeWindow.week,
          ),
        ],
      ),
    );
  }
}
