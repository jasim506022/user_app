import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_app/res/app_function.dart';

import '../res/utils.dart';

class LoadingsUserProfileHeader extends StatelessWidget {
  const LoadingsUserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();
    return SizedBox(
      height: 50.h,
      width: 1.sw,
      child: Shimmer.fromColors(
        baseColor: utils.baseShimmerColor,
        highlightColor: utils.highlightShimmerColor,
        child: Row(
          children: [
            AppsFunction.circleShimmer(utils, 50.h),
            SizedBox(
              width: 13.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppsFunction.lineShimmer(utils, 10.h, .55.sw),
                AppsFunction.lineShimmer(utils, 10.h, .55.sw),
              ],
            ),
            const Spacer(),
            AppsFunction.circleShimmer(utils, 35.h),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
}
