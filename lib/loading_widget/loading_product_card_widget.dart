import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_function.dart';
import '../res/utils.dart';

class LoadingProductCardWidget extends StatelessWidget {
  const LoadingProductCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120.h,
          width: .9.sw,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r)),
          child: Shimmer.fromColors(
            baseColor: Utils.baseShimmerColor,
            highlightColor: Utils.highlightShimmerColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppsFunction.lineShimmer(110, 130),
                AppsFunction.horizontalSpace(10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppsFunction.lineShimmer(15),
                      AppsFunction.lineShimmer(15),
                      AppsFunction.lineShimmer(15),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
