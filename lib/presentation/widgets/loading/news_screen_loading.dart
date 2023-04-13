import 'package:flutter/material.dart';

import 'recommended_card_shimmer.dart';
import '../../../consts/app_typography.dart';
import 'carousel_slider_shimmer.dart';

class NewsScreenLoading extends StatelessWidget {
  const NewsScreenLoading({Key? key}) : super(key: key);

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
              const TextButton(
                onPressed: null,
                child: Text('View all'),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const CarouselShimmer(),
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
                  const TextButton(
                    onPressed: null,
                    child: Text('View all'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const RecommendedCardShimmer(),
            ],
          ),
        )
      ],
    );
  }
}
