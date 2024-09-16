import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../res/utils.dart';

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
          height: 130.h,
          width: 100.w,
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.only(left: 15.w),
          color: Theme.of(context).cardColor,
          child: Shimmer.fromColors(
            baseColor: utils.baseShimmerColor,
            highlightColor: utils.highlightShimmerColor,
            child: Column(
              children: [
                _buildShimmerTheme(utils, 70),
                SizedBox(
                  height: 8.h,
                ),
                _buildShimmerTheme(utils, 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildShimmerTheme(Utils utils, double height) {
    return Container(
      height: height,
      width: 80.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: utils.widgetShimmerColor),
    );
  }
}
