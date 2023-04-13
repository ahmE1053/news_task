import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:task1/consts/app_typography.dart';

import '../../data_source/online_data_source.dart';
import '../../models/news_model.dart';
import '../widgets/error_text.dart';
import '../widgets/loading/recommended_card_shimmer.dart';
import '../widgets/news_screen/recommended_news_list.dart';
import '../widgets/text_field.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final containerAboveSearchHeight = useState(mq.height * 0.1);
    final searchTextController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final errorState = useState(false);
    final loading = useState(false);
    final newsStories = useState(<NewsStoryModel>[]);
    final textDirection = useState(TextDirection.ltr);
    final didSearch = useState(false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: containerAboveSearchHeight.value,
                ),
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: formKey,
                  child: MyTextField(
                    textDirection: textDirection,
                    controller: searchTextController,
                    colorScheme: Theme.of(context).colorScheme,
                    onSubmitted: (value) async {
                      if (formKey.currentState!.validate()) {
                        loading.value = true;
                        didSearch.value = true;
                        (await search(value!.trim())).fold(
                          (l) {
                            errorState.value = true;
                            containerAboveSearchHeight.value = mq.height * 0.1;
                            loading.value = false;
                          },
                          (r) {
                            newsStories.value = r;
                            loading.value = false;
                            containerAboveSearchHeight.value = 10;
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              Builder(
                builder: (context) {
                  if (loading.value) {
                    return const SliverToBoxAdapter(
                        child: RecommendedCardShimmer());
                  }
                  if (errorState.value) {
                    return const SliverFillRemaining(child: ErrorTextWidget());
                  }
                  if (didSearch.value && newsStories.value.isEmpty) {
                    final listChildren = [
                      Flexible(
                        child: Lottie.asset(
                          'assets/search_not_found.json',
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(width: 20),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Your search didn\'t come up with any results',
                          style: AppTypography.bodySize(context),
                        ),
                      ),
                    ];
                    return SliverFillRemaining(
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          if (orientation == Orientation.portrait) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: listChildren,
                            );
                          }
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: listChildren);
                        },
                      ),
                    );
                  }
                  if (newsStories.value.isEmpty) {
                    final listChildren = [
                      Flexible(
                        child: Lottie.asset('assets/search.json'),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(width: 20),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Please enter some search terms.',
                          style: AppTypography.bodySize(context),
                        ),
                      ),
                    ];
                    return SliverFillRemaining(
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          if (orientation == Orientation.portrait) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: listChildren);
                          }
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: listChildren);
                        },
                      ),
                    );
                  }
                  return SliverToBoxAdapter(
                    child: RecommendedNewsList(
                      stories: newsStories.value,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
