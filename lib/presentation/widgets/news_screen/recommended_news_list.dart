import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task1/presentation/widgets/news_screen/recommended_card.dart';

import '../../../models/news_model.dart';

class RecommendedNewsList extends ConsumerWidget {
  const RecommendedNewsList({
    required this.stories,
    Key? key,
  }) : super(key: key);

  final List<NewsStoryModel> stories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: stories
          .map(
            (story) => SizedBox(
              height: mq.height * 0.15,
              child: RecommendedCard(
                story: story,
              ),
            ),
          )
          .toList(),
    );
  }
}
