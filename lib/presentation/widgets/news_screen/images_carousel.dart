import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'image_carousel_widget.dart';

import '../../../models/news_model.dart';

class NewsCarousel extends HookConsumerWidget {
  const NewsCarousel({Key? key, required this.newsStories}) : super(key: key);
  final List<NewsStoryModel> newsStories;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final carouselController = useMemoized(() => CarouselController());
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: newsStories.length,
          itemBuilder: (context, index, realIndex) {
            final newsStory = newsStories[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ImageCarouselWidget(
                newsStory: newsStory,
                colorScheme: colorScheme,
              ),
            );
          },
          options: CarouselOptions(
            height: size.height * 0.3,
            // autoPlay: true,
            initialPage: 0,
            enableInfiniteScroll: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
          ),
        ),
        const SizedBox(height: 8),
        AnimatedSmoothIndicator(
          activeIndex: currentIndex.value,
          count: newsStories.length,
          effect: const ExpandingDotsEffect(),
          onDotClicked: (index) {
            currentIndex.value = index;
            carouselController.animateToPage(index);
          },
        ),
      ],
    );
  }
}
