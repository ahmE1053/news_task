import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../consts/app_typography.dart';
import '../../../core/providers/user_provider.dart';
import '../../../models/news_related.dart';
import 'details_appbar.dart';

class DetailsImageStack extends HookConsumerWidget {
  const DetailsImageStack(
      {Key? key,
      required this.newsStory,
      required this.bottomInset,
      required this.opacity})
      : super(key: key);
  final NewsStoryModel newsStory;
  final double bottomInset;
  final double opacity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(userNotifierProvider).bookmarks;
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 200));
    final colorAnimation =
        ColorTween(begin: Colors.white, end: Colors.black).animate(controller);
    final mq = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        //background image
        Hero(
          tag: newsStory.imageUrl,
          child: Image.asset(
            newsStory.imageUrl,
            fit: BoxFit.fill,
          ),
        ),

        //black gradient in bottom to make text readable if background image is on the whiter side
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.6],
            ),
          ),
        ),

        //puts a white color on the image to kinda remove the image
        Container(
          color: Colors.white.withOpacity(opacity),
        ),

        //column with different stuff like the app bar and the news story info
        Positioned(
          top: 0,
          height: bottomInset,
          width: mq.width,
          //safe area to make the app bar below the status bar
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //app bar
                  DetailsAppBar(
                    bookmarked: bookmarks.contains(newsStory),
                    onTap: () {
                      ref
                          .read(userNotifierProvider.notifier)
                          .handleFavorite(newsStory, true);
                    },
                  ),
                  //info about the article
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //category pill
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            newsStory.category,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.semiBodySize(
                              context,
                              Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),

                        //text that changes it colors dynamically based on the opacity of the background
                        AnimatedBuilder(
                          animation: colorAnimation,
                          builder: (context, child) {
                            if (opacity > 0.5) {
                              if (!controller.isCompleted) {
                                controller.forward();
                              }
                            } else {
                              if (controller.isCompleted) {
                                controller.reverse();
                              }
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsStory.title,
                                  style: AppTypography.semiHeadlineSize(
                                    context,
                                    colorAnimation.value,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Trending • ${newsStory.time}',
                                  style: AppTypography.semiBodySize(
                                    context,
                                    colorAnimation.value,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
