import 'package:flutter/material.dart';

import 'blurred_icon_button.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({
    super.key,
    required this.onTap,
    required this.bookmarked,
    this.favoriteLoading = false,
  });
  final void Function() onTap;
  final bool bookmarked, favoriteLoading;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlurredIconButton(
          onTap: () {
            Navigator.pop(context);
          },
          icon: Icons.arrow_back,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlurredIconButton(
                favoriteLoading: favoriteLoading,
                onTap: onTap,
                icon: bookmarked
                    ? Icons.bookmark
                    : Icons.bookmark_border_outlined,
              ),
              const SizedBox(width: 8),
              BlurredIconButton(
                onTap: () {},
                icon: Icons.more_horiz,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
