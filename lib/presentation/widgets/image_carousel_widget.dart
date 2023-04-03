import 'package:flutter/material.dart';
import 'package:task1/screens/details_screen.dart';

import '../consts/app_typography.dart';
import '../models/news_related.dart';

class ImageCarouselWidget extends StatelessWidget {
  const ImageCarouselWidget({
    super.key,
    required this.newsStory,
    required this.colorScheme,
  });

  final NewsStoryModel newsStory;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryDetailsScreen(newsStory: newsStory),
          ),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: newsStory.imageUrl,
            child: Image.asset(
              newsStory.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black87,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      newsStory.category,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          newsStory.source,
                          style: AppTypography.semiBodySize(
                            context,
                            Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (newsStory.verifiedSource)
                          const CircleAvatar(
                            radius: 10,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: FittedBox(
                                child: Icon(
                                  Icons.check,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          newsStory.time,
                          style: AppTypography.semiBodySize(
                            context,
                            Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      newsStory.title,
                      style: AppTypography.semiHeadlineSize(
                        context,
                        Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
