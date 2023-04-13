import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../core/providers/news_providers.dart';

class ConnectionErrorWidget extends StatelessWidget {
  const ConnectionErrorWidget({Key? key, required this.ref}) : super(key: key);
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Lottie.asset('assets/404.json', fit: BoxFit.fill),
          const FittedBox(
            child: Text(
              'Oh snap! Looks like a hiccup in the connection. \nBut no worries, we\'ve got this! Just a quick tap on that \nreload button, and we\'ll be back on track. \nLet\'s team up and show this tech who\'s boss! ',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(
                topNewsProvider,
              );
            },
            child: const Text('Reload'),
          ),
        ],
      ),
    );
  }
}
