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
    Utils utils = Utils();

    return Column(
      children: [
        Container(
          height: 120.h,
          width: .9.sw,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r)),
          child: Shimmer.fromColors(
            baseColor: utils.baseShimmerColor,
            highlightColor: utils.highlightShimmerColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppsFunction.lineShimmer(utils, 110.h, 130.w),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppsFunction.lineShimmer(utils, 15.h),
                      AppsFunction.lineShimmer(utils, 15.h),
                      AppsFunction.lineShimmer(utils, 15.h),
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
