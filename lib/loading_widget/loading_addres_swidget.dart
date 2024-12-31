import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_app/res/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_function.dart';

class LoadingAddressWidget extends StatelessWidget {
  const LoadingAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 78.h,
      width: 1.sw,
      margin: EdgeInsets.symmetric(vertical: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: Utils.green50, borderRadius: BorderRadius.circular(25.r)),
      child: Shimmer.fromColors(
        baseColor: Utils.baseShimmerColor,
        highlightColor: Utils.highlightShimmerColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      AppsFunction.lineShimmer(20, 30),
                      AppsFunction.horizontalSpace(20),
                      AppsFunction.lineShimmer(20, 45),
                    ],
                  ),
                  AppsFunction.verticleSpace(10),
                  AppsFunction.lineShimmer(10),
                  AppsFunction.verticleSpace(10),
                  AppsFunction.lineShimmer(10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
