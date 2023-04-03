import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../consts/app_typography.dart';
import '../../consts/ipsum.dart';
import '../../models/news_related.dart';
import '../widgets/details_screen/details_screen_image_stack.dart';

class StoryDetailsScreen extends HookConsumerWidget {
  const StoryDetailsScreen({
    Key? key,
    required this.newsStory,
  }) : super(key: key);
  final NewsStoryModel newsStory;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final size = MediaQuery.of(context).size;
    final topStackHeight = useState(size.height * 0.6);
    final colorOpacity = useState(0.0);
    final containerRadius = useState(50.0);
    useEffect(() {
      double scrollingPercentage = 0.0;
      double minimum = size.height * 0.6;
      double maximum = size.height * 0.35;
      scrollController.addListener(
        () {
          //used to get a percentage of the total length of scrolling extent
          final percentageOfTotalScrollExtent =
              scrollController.position.maxScrollExtent * 0.4;

          //normalizes this percentage to a value between 0 and 1
          scrollingPercentage =
              min(scrollController.offset / percentageOfTotalScrollExtent, 1);

          //used to not change to the white color immediately and wait a bit
          if (scrollingPercentage >= 0.5) {
            colorOpacity.value = scrollingPercentage.getRangeFromAnotherRange(
                0.5, 1.0, 0.0, 1.0);
          }
          if (scrollController.offset == 0 && colorOpacity.value > 0.0) {
            colorOpacity.value = 0.0;
          }

          //changes the container height without decreasing the image height
          topStackHeight.value = scrollingPercentage.getRangeFromAnotherRange(
              0.0, 1.0, minimum, maximum);

          //changes the container border to give a cool effect when scrolling
          containerRadius.value =
              (1 - scrollingPercentage).getRangeFromZeroToOne(0.0, 50.0);
        },
      );
      return null;
    }, [scrollController]);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            height: size.height * 0.6,
            width: size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                DetailsImageStack(
                  newsStory: newsStory,
                  bottomInset: topStackHeight.value * 0.8,
                  opacity: colorOpacity.value,
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: topStackHeight.value * 0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(containerRadius.value),
                  topLeft: Radius.circular(containerRadius.value),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                padding: EdgeInsets.zero,
                controller: scrollController,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FittedBox(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              newsStory.sourceImage,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Center(
                          child: Text(
                            newsStory.source,
                            style: AppTypography.semiHeadlineSize(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (newsStory.verifiedSource)
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    loremIpsum,
                    style: AppTypography.semiBodySize(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension Range<T extends double> on num {
  T getRangeFromAnotherRange(T oldMin, T oldHigh, T newMin, T newHigh) {
    T newValue = ((this - oldMin) / (oldHigh - oldMin) * (newHigh - newMin) +
        newMin) as T;
    return newValue;
  }

  T getRangeFromZeroToOne(T min, T high) {
    T newValue = ((this - 0.0) / (1.0 - 0.0) * (high - min) + min) as T;
    return newValue;
  }
}
