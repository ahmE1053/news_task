import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';

import '../core/exceptions.dart';
import '../models/news_model.dart';

class LocalDataSourceNotifier {
  Future<Either<ApiException, List<NewsStoryModel>>> build() async {
    try {
      final isar =
          await Isar.open(name: 'generalDatabase', [NewsStoryModelSchema]);
      final newsStories = await isar.newsStoryModels.where().findAll();
      await isar.close();
      if (newsStories.isEmpty) return const Left(ApiException('Empty List'));
      return Right(newsStories);
    } catch (e) {
      return const Left(ApiException('Unknown error'));
    }
  }
}
