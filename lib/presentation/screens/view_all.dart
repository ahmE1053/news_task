import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task1/presentation/widgets/loading/recommended_card_shimmer.dart';
import 'package:task1/presentation/widgets/news_screen/recommended_card.dart';
import 'package:task1/presentation/widgets/view_all_pagination.dart';

import '../../core/providers/news_providers.dart';
import '../widgets/connection_error_widget.dart';

class ViewAllScreen extends HookConsumerWidget {
  const ViewAllScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offlineContainerSize = useState(0.0);
    final newsRef = ref.watch(topNewsProvider);
    final mq = MediaQuery.of(context).size;
    final scrollController = useScrollController();

    useEffect(() {
      var onePaginationAtATime = true;
      var firstTimePagination = true;
      scrollController.addListener(
        () {
          if (scrollController.position.maxScrollExtent == 0.0 &&
              firstTimePagination) {
            ref.read(topNewsProvider.notifier).paginationInScreen();
            firstTimePagination = false;
          }
          if (scrollController.offset >
                  scrollController.position.maxScrollExtent - 100 &&
              scrollController.position.maxScrollExtent > 200 &&
              onePaginationAtATime) {
            onePaginationAtATime = false;
            ref.read(topNewsProvider.notifier).paginationInScreen();
          }

          if (scrollController.offset <
                  max(scrollController.position.maxScrollExtent - 300, 100) &&
              !onePaginationAtATime) {
            onePaginationAtATime = true;
          }
        },
      );
      return null;
    }, [scrollController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Stories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(topNewsProvider.notifier).toggleMockLoading();
            await Future.delayed(const Duration(seconds: 2));
            ref.invalidate(topNewsProvider);
          },
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            controller: scrollController,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: offlineContainerSize.value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.redAccent,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.all(16),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Using cached data due to a connection error. Try pull-to-refresh',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              newsRef.when(
                data: (data) => data.fold(
                  (local) => local.fold(
                    (error) => ConnectionErrorWidget(ref: ref),
                    (localStories) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) {
                          offlineContainerSize.value = mq.height * 0.05;
                        },
                      );
                      return Column(
                        children: localStories
                            .map((story) => SizedBox(
                                height: mq.height * 0.15,
                                child: RecommendedCard(story: story)))
                            .toList(),
                      );
                    },
                  ),
                  (stories) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        offlineContainerSize.value = 0;
                      },
                    );
                    return Column(
                      children: stories
                          .map((story) => SizedBox(
                              height: mq.height * 0.15,
                              child: RecommendedCard(story: story)))
                          .toList(),
                    );
                  },
                ),
                error: (error, stackTrace) => const Text('error'),
                loading: () => const RecommendedCardShimmer(),
              ),
              const ViewAllPagination(),
            ],
          ),
        ),
      ),
    );
  }
}
