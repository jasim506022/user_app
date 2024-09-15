import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_colors.dart';
import '../res/utils.dart';

class LodingHeader extends StatelessWidget {
  const LodingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return SizedBox(
      height: 36.h,
      width: 1.sw,
      child: Shimmer.fromColors(
        baseColor: utils.baseShimmerColor,
        highlightColor: utils.highlightShimmerColor,
        child: Row(
          children: [
            // User Profile Image
            Container(
              height: 36.h,
              width: 36.h,
              decoration: BoxDecoration(
                  color: utils.widgetShimmerColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.red, width: 3.w)),
            ),

            SizedBox(
              width: 13.w,
            ),

            // User Informatiokn
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 7.h,
                  width: 100.w,
                  color: utils.widgetShimmerColor,
                ),
                Container(
                  height: 10.h,
                  width: 150.w,
                  color: utils.widgetShimmerColor,
                )
              ],
            ),
            const Spacer(),

            Container(
              height: 25.h,
              width: 25.h,
              decoration: BoxDecoration(
                color: utils.widgetShimmerColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
}
