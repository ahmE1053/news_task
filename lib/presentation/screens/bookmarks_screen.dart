import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../consts/app_typography.dart';
import '../../core/providers/user_provider.dart';
import '../widgets/article_card.dart';

class BookmarksScreen extends HookConsumerWidget {
  const BookmarksScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);
    final bookmarks = user.bookmarks;
    final listKey = useMemoized(() => GlobalKey<AnimatedListState>());
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: bookmarks.isEmpty
            ? Center(
                child: FittedBox(
                  child: Text(
                    'You didn\'t add any bookmarks yet.',
                    style: AppTypography.bodySize(context),
                  ),
                ),
              )
            : AnimatedList(
                key: ref.read(listKeyProvider),
                initialItemCount: bookmarks.length,
                itemBuilder: (context, index, animation) {
                  final article = bookmarks[index];
                  return SizedBox(
                    height: mq.height * 0.15,
                    child: ArticleCard(
                      article: article,
                      bookmarkMode: true,
                      onTap: () async {
                        if (bookmarks.length == 1) {
                          ref.read(listKeyProvider).currentState!.removeItem(
                                index,
                                (context, animation) => SizeTransition(
                                  sizeFactor: animation,
                                  child: SizedBox(
                                    height: mq.height * 0.15,
                                    child: ArticleCard(
                                      article: article,
                                      bookmarkMode: true,
                                      bookmarked: false,
                                    ),
                                  ),
                                ),
                                duration: const Duration(milliseconds: 500),
                              );

                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          ref
                              .read(userNotifierProvider.notifier)
                              .handleFavorite(article, false);
                          return;
                        }
                        ref
                            .read(userNotifierProvider.notifier)
                            .handleFavorite(article, false);
                        ref.read(listKeyProvider).currentState!.removeItem(
                              index,
                              (context, animation) => SizeTransition(
                                sizeFactor: animation,
                                child: SizedBox(
                                  height: mq.height * 0.15,
                                  child: ArticleCard(
                                    article: article,
                                    bookmarkMode: true,
                                    bookmarked: false,
                                  ),
                                ),
                              ),
                              duration: const Duration(milliseconds: 500),
                            );
                      },
                    ),
                  );
                }),
      ),
    );
  }
}
