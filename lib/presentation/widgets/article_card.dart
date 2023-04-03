import 'package:flutter/material.dart';

import '../../consts/app_typography.dart';
import '../../models/news_related.dart';
import '../screens/details_screen.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.article,
    this.bookmarkMode = false,
    this.onTap,
    this.bookmarked = true,
  }) : super(key: key);
  final NewsStoryModel article;
  final bool bookmarkMode, bookmarked;

  final void Function()? onTap;
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
                builder: (context) => StoryDetailsScreen(newsStory: article),
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
                            child: Hero(
                              tag: article.imageUrl,
                              child: Image.asset(
                                article.imageUrl,
                                fit: BoxFit.fill,
                              ),
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
                                  article.category,
                                  style: AppTypography.smallSize(
                                      context, Colors.grey),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      article.title,
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
                                            article.sourceImage,
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
                                            '${article.source} • ${article.time}',
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
                    onPressed: onTap,
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
