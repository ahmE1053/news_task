import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecommendedCardShimmer extends StatelessWidget {
  const RecommendedCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Column(
      children: [
        ...List.generate(
          5,
          (index) => LayoutBuilder(builder: (context, size) {
            return SizedBox(
              height: mq.height * 0.15,
              child: Row(
                children: [
                  SizedBox(
                    width: size.maxWidth * 0.3,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.1),
                      highlightColor: Colors.white,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.white,
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.white,
                              child: Container(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  width: size.maxWidth * 0.2,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.1),
                                    highlightColor: Colors.white,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.1),
                                    highlightColor: Colors.white,
                                    child: Container(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
