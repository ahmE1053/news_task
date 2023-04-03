import 'package:flutter/material.dart';

import '../consts/app_typography.dart';
import '../models/news_related.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({Key? key, required this.article}) : super(key: key);
  final NewsStoryModel article;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return Column(
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
                            style:
                                AppTypography.smallSize(context, Colors.grey),
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                article.title,
                                textAlign: TextAlign.start,
                                style: AppTypography.semiBodySize(context),
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
                                    alignment: AlignmentDirectional.centerStart,
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
        );
      },
    );
  }
}
