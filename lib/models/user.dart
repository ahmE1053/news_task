import 'package:isar/isar.dart';
import 'package:task1/models/news_model.dart';

class User {
  final Id id = Isar.autoIncrement;
  const User(this.bookmarks);

  final List<NewsStoryModel> bookmarks;
  User copyWith(List<NewsStoryModel> list) {
    return User(list);
  }
}
