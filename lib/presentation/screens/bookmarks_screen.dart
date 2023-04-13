import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task1/presentation/widgets/loading/recommended_card_shimmer.dart';

import '../../consts/app_typography.dart';
import '../../core/providers/user_provider.dart';
import '../widgets/news_screen/recommended_card.dart';

class BookmarksScreen extends HookConsumerWidget {
  const BookmarksScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user.when(
          data: (user) {
            final bookmarks = user.bookmarks;
            if (bookmarks.isEmpty) {
              return Center(
                child: FittedBox(
                  child: Text(
                    'You didn\'t add any bookmarks yet.',
                    style: AppTypography.bodySize(context),
                  ),
                ),
              );
            }
            return AnimatedList(
              key: ref.read(listKeyProvider),
              initialItemCount: bookmarks.length,
              itemBuilder: (context, index, animation) {
                final story = bookmarks[index];
                return SizedBox(
                  height: mq.height * 0.15,
                  child: RecommendedCard(
                    story: story,
                    bookmarkMode: true,
                    onBookmarkTap: () async {
                      if (bookmarks.length == 1) {
                        ref.read(listKeyProvider).currentState!.removeItem(
                              index,
                              (context, animation) => SizeTransition(
                                sizeFactor: animation,
                                child: SizedBox(
                                  height: mq.height * 0.15,
                                  child: RecommendedCard(
                                    story: story,
                                    bookmarkMode: true,
                                    bookmarked: false,
                                  ),
                                ),
                              ),
                              duration: const Duration(milliseconds: 500),
                            );

                        await Future.delayed(const Duration(milliseconds: 500));
                        ref
                            .read(userNotifierProvider.notifier)
                            .handleFavorite(story, false);
                        return;
                      }
                      ref.read(userNotifierProvider.notifier).handleFavorite(
                            story,
                            false,
                          );
                      ref.read(listKeyProvider).currentState!.removeItem(
                            index,
                            (context, animation) => SizeTransition(
                              sizeFactor: animation,
                              child: SizedBox(
                                height: mq.height * 0.15,
                                child: RecommendedCard(
                                  story: story,
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
              },
            );
          },
          error: (error, stackTrace) => const Center(
            child: FittedBox(
              child: Text('An error occurred, please try reloading'),
            ),
          ),
          loading: () => ListView(
            children: const [RecommendedCardShimmer()],
          ),
        ),
      ),
    );
  }
}
