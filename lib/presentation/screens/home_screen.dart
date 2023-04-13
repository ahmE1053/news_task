import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../widgets/bottom_nav_bar.dart';
import 'bookmarks_screen.dart';
import 'news_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: mainScreens(context, currentIndex.value, size),
      bottomNavigationBar: MyBottomNavBar(currentIndex: currentIndex),
    );
  }
}

Widget mainScreens(BuildContext context, int index, Size size) {
  if (index != 2) {
    index = 0;
  } else {
    index = 1;
  }
  var screens = [
    const NewsScreen(),
    const BookmarksScreen(),
  ];
  return screens[index];
}
