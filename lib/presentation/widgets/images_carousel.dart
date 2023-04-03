import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data_source/news_mock.dart';
import 'image_carousel_widget.dart';

class NewsCarousel extends HookWidget {
  const NewsCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    final carouselController = useMemoized(() => CarouselController());

    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: news.length,
          itemBuilder: (context, index, realIndex) {
            final newsStory = news[index];
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
          count: news.length,
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
