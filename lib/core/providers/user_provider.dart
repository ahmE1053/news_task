import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/news_model.dart';
import '../../models/user.dart';

class UserNotifier extends AsyncNotifier<User> {
  @override
  Future<User> build() async {
    final isar = await Isar.open(
      name: 'bookmarks',
      [NewsStoryModelSchema],
    );
    final newsStories = await isar.newsStoryModels.where().findAll();
    await isar.close();
    return User(newsStories);
  }

  Future<void> handleFavorite(
    NewsStoryModel selectedStory,
    bool inDetailsScreen, [
    ValueNotifier<bool>? favoriteLoading,
  ]) async {
    state.whenData(
      (value) async {
        try {
          favoriteLoading?.value = true;
          final List<NewsStoryModel> list = List.from(value.bookmarks);
          final isar =
              await Isar.open(name: 'bookmarks', [NewsStoryModelSchema]);
          if (!list.contains(selectedStory)) {
            await isar.writeTxn(
              () async {
                await isar.newsStoryModels.put(selectedStory);
              },
            );
            list.add(selectedStory);
            state = AsyncData(value.copyWith(list));
          } else {
            if (inDetailsScreen) {
              if (ref.read(listKeyProvider).currentState != null) {
                ref.read(listKeyProvider).currentState!.removeItem(
                      list.indexOf(selectedStory),
                      (context, animation) => Container(),
                    );
              }
            }
            await isar.writeTxn(
              () async {
                await isar.newsStoryModels.delete(selectedStory.id);
              },
            );
            list.remove(selectedStory);
            state = AsyncData(value.copyWith(list));
          }
          await isar.close();
          favoriteLoading?.value = false;
        } catch (e) {
          favoriteLoading?.value = false;
        }
      },
    );
  }
}

final userNotifierProvider = AsyncNotifierProvider<UserNotifier, User>(
  () => UserNotifier(),
);

final listKeyProvider = Provider((ref) => GlobalKey<AnimatedListState>());
