import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/news_related.dart';
import '../../models/user.dart';

class UserNotifier extends Notifier<User> {
  @override
  User build() {
    return const User([]);
  }

  Future<void> handleFavorite(
      NewsStoryModel value, bool inDetailsScreen) async {
    final List<NewsStoryModel> list = List.from(state.bookmarks);
    if (!list.contains(value)) {
      list.add(value);
      state = state.copyWith(list);
    } else {
      if (inDetailsScreen) {
        if (ref.read(listKeyProvider).currentState != null) {
          ref.read(listKeyProvider).currentState!.removeItem(
                list.indexOf(value),
                (context, animation) => Container(),
              );
        }
      }
      list.remove(value);
      state = state.copyWith(list);
    }
  }
}

final userNotifierProvider = NotifierProvider<UserNotifier, User>(
  () => UserNotifier(),
);

final listKeyProvider = Provider((ref) => GlobalKey<AnimatedListState>());
