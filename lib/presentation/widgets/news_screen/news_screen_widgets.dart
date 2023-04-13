import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task1/core/providers/news_providers.dart';
import 'package:task1/presentation/screens/view_all.dart';

import 'recommended_news_list.dart';
import '../../../consts/app_typography.dart';
import '../../../models/news_model.dart';
import 'images_carousel.dart';

class NewsScreenWidgets extends StatelessWidget {
  const NewsScreenWidgets({Key? key, required this.stories, required this.ref})
      : super(key: key);

  final List<NewsStoryModel> stories;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Text(
                  'Breaking News',
                  style: AppTypography.semiHeadlineSize(context),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(topNewsProvider.notifier).paginationFromPush();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewAllScreen(),
                    ),
                  );
                },
                child: const Text('View all'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        NewsCarousel(newsStories: stories.take(5).toList()),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      'Recommended',
                      style: AppTypography.semiHeadlineSize(context),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(topNewsProvider.notifier).paginationFromPush();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewAllScreen(),
                        ),
                      );
                    },
                    child: const Text('View all'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RecommendedNewsList(
                stories: stories.take(5).toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
