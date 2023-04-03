import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredIconButton extends StatelessWidget {
  const BlurredIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });
  final void Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
