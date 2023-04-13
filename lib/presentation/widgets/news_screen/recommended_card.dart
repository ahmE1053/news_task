import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../consts/app_typography.dart';
import '../../../models/news_model.dart';
import '../../screens/details_screen.dart';

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
    Key? key,
    required this.story,
    this.bookmarkMode = false,
    this.onBookmarkTap,
    this.bookmarked = true,
  }) : super(key: key);
  final NewsStoryModel story;
  final bool bookmarkMode, bookmarked;

  final void Function()? onBookmarkTap;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryDetailsScreen(newsStory: story),
              ),
            );
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: size.maxWidth * 0.3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CachedNetworkImage(
                              imageUrl: story.imageUrl,
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/not_found.png',
                                fit: BoxFit.fill,
                              ),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  story.category,
                                  style: AppTypography.smallSize(
                                      context, Colors.grey),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      story.title,
                                      textAlign: TextAlign.start,
                                      style:
                                          AppTypography.semiBodySize(context),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FittedBox(
                                        child: CircleAvatar(
                                          foregroundImage: AssetImage(
                                            story.sourceImage,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            '${story.source} • ${story.time}',
                                            style: AppTypography.smallSize(
                                              context,
                                              Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              if (bookmarkMode)
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: onBookmarkTap,
                    icon: Icon(
                      bookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
