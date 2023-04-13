import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredIconButton extends StatelessWidget {
  const BlurredIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.favoriteLoading = false,
  });
  final void Function() onTap;
  final IconData icon;
  final bool favoriteLoading;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          child: Builder(builder: (context) {
            if (favoriteLoading) {
              return const CircularProgressIndicator();
            }
            return IconButton(
              onPressed: onTap,
              icon: Icon(
                icon,
                color: Colors.white,
              ),
            );
          }),
        ),
      ),
    );
  }
}
