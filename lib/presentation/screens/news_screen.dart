import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:task1/presentation/screens/search_screen.dart';
import 'package:task1/presentation/widgets/connection_error_widget.dart';

import '../../core/providers/news_providers.dart';
import '../widgets/loading/news_screen_loading.dart';
import '../widgets/news_screen/news_screen_widgets.dart';

class NewsScreen extends HookConsumerWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQuery.of(context).size;
    final newsRef = ref.watch(topNewsProvider);
    final offlineContainerSize = useState(0.0);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Badge(
              alignment: AlignmentDirectional.topEnd,
              backgroundColor: Colors.red,
              child: Icon(Icons.notifications),
            ),
          )
        ],
      ),
      drawer: const Drawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(topNewsProvider.notifier).toggleMockLoading();
          await Future.delayed(const Duration(seconds: 2));
          ref.invalidate(topNewsProvider);
        },
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: ListView(
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
                    return NewsScreenWidgets(
                      stories: localStories,
                      ref: ref,
                    );
                  },
                ),
                (stories) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      offlineContainerSize.value = 0;
                    },
                  );
                  return NewsScreenWidgets(
                    stories: stories,
                    ref: ref,
                  );
                },
              ),
              error: (error, stackTrace) => const Text('error'),
              loading: () => const NewsScreenLoading(),
            ),
          ],
        ),
      ),
    );
  }
}
