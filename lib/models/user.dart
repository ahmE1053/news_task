import 'package:task1/models/news_related.dart';

class User {
  const User(this.bookmarks);
  final List<NewsStoryModel> bookmarks;
  User copyWith(List<NewsStoryModel> list) {
    return User(list);
  }
}
