import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';

import '../../data_source/online_data_source.dart';
import '../../models/news_model.dart';
import '../exceptions.dart';

final topNewsProvider = AsyncNotifierProvider<TopNewsDataSourceNotifier,
    Either<Either<ApiException, List<NewsStoryModel>>, List<NewsStoryModel>>>(
  () => TopNewsDataSourceNotifier(),
);
