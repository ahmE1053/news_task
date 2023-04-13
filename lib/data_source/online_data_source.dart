import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:task1/core/exceptions.dart';

import '../consts/api_info.dart';
import '../core/utilities/json_parser.dart';
import '../models/news_model.dart';
import 'local_data_source.dart';

class TopNewsDataSourceNotifier extends AsyncNotifier<
    Either<Either<ApiException, List<NewsStoryModel>>, List<NewsStoryModel>>> {
  var pageIndex = 1;
  List<NewsStoryModel> stories = [];
  bool loading = false;
  int totalResults = 0;
  @override
  Future<
      Either<Either<ApiException, List<NewsStoryModel>>,
          List<NewsStoryModel>>> build() async {
    try {
      loading = true;

      final response = await Dio().get(
        ApiInfo.topPath,
        queryParameters: {
          'country': 'us',
          'pageSize': '${pageIndex == 1 ? 5 : 10}',
          'page': '$pageIndex',
        },
        options: Options(
          headers: {'X-Api-Key': ApiInfo.apiKey},
        ),
      );

      totalResults = response.data['totalResults'];

      if (response.data['status'] != 'ok' || response.statusCode != 200) {
        throw '';
      }

      final newsStories = jsonParser(response.data['articles']);

      stories = [...stories, ...newsStories];

      final isar =
          Isar.openSync(name: 'generalDatabase', [NewsStoryModelSchema]);
      isar.writeTxnSync(
        () {
          isar.clearSync();
          isar.newsStoryModels.putAllSync(newsStories);
        },
      );
      isar.close();

      loading = false;
      return Right(stories);
    } catch (e) {
      loading = false;
      final local = await LocalDataSourceNotifier().build();
      return Left(local);
    }
  }

  Stream<bool> isPaginationLoadingStream() async* {
    while (true) {
      yield loading;
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void paginationInScreen() async {
    if (totalResults < (pageIndex * 10) + 5) {
      return;
    }
    pageIndex++;
    ref.invalidateSelf();
  }

  void paginationFromPush() async {
    if (pageIndex == 1) {
      pageIndex++;
      ref.invalidateSelf();
    }
  }

  void toggleMockLoading() {
    state = const AsyncLoading();
  }
}

Future<Either<ApiException, List<NewsStoryModel>>> search(
    String searchText) async {
  try {
    final response = await Dio().get(
      ApiInfo.searchPath,
      queryParameters: {
        'q': searchText,
        'sortBy': 'publishedAt',
      },
      options: Options(
        headers: {'X-Api-Key': ApiInfo.apiKey},
      ),
    );
    if (response.data['status'] != 'ok' || response.statusCode != 200) {
      throw 'an error with the server occurred';
    }
    final newsStories = jsonParser(response.data['articles']);
    return Right(newsStories);
  } catch (e) {
    return Left(
      ApiException(e.toString()),
    );
  }
}
