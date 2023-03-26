import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({Key? key, required this.currentIndex})
      : super(key: key);
  final ValueNotifier<int> currentIndex;
  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: currentIndex.value,
      onTap: (p0) => currentIndex.value = p0,
      margin: const EdgeInsets.all(16),
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          activeIcon: const Icon(Icons.home),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.sports_basketball_outlined),
          title: const Text('All'),
          activeIcon: const Icon(Icons.sports_basketball),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.bookmark_border_outlined),
          title: const Text('Saved'),
          activeIcon: const Icon(Icons.bookmark),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.person_outline),
          title: const Text('Profile'),
          activeIcon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
