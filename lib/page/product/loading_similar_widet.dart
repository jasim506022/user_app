import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/utils.dart';

class LoadingSimilierWidget extends StatelessWidget {
  const LoadingSimilierWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          height: 150,
          width: 100,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 15),
          color: Theme.of(context).cardColor,
          child: Shimmer.fromColors(
            baseColor: utils.baseShimmerColor,
            highlightColor: utils.highlightShimmerColor,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: utils.widgetShimmerColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: utils.widgetShimmerColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
