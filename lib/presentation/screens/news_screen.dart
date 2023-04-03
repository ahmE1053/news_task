import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../consts/app_typography.dart';
import '../../data_source/news_mock.dart';
import '../widgets/article_card.dart';
import '../widgets/images_carousel.dart';

class NewsScreen extends HookWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Badge(
              alignment: AlignmentDirectional.topEnd,
              backgroundColor: Colors.red,
              child: Icon(Icons.notifications),
            ),
          )
        ],
      ),
      drawer: const Drawer(),
      body: ListView(
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
                  onPressed: () {},
                  child: const Text('View all'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const NewsCarousel(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        'Breaking News',
                        style: AppTypography.semiHeadlineSize(context),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View all'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...recommended.map(
                  (e) => SizedBox(
                    height: size.height * 0.15,
                    child: ArticleCard(
                      article: e,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
