import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/providers/news_providers.dart';

class ViewAllPagination extends HookConsumerWidget {
  const ViewAllPagination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = useStream(
      useMemoized(
          () => ref.read(topNewsProvider.notifier).isPaginationLoadingStream()),
    );
    if (stream.data == true || stream.data == null) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 20),
        ],
      );
    }
    return Container();
  }
}
