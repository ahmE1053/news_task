import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.1),
            highlightColor: Colors.white70,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
              ),
              margin: const EdgeInsets.all(16),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: size.height * 0.3,
        initialPage: 0,
        enableInfiniteScroll: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        enlargeCenterPage: true,
      ),
    );
  }
}
