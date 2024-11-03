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
    Utils utils = Utils();
    return Container(
      alignment: Alignment.center,
      height: 78.h,
      width: 1.sw,
      margin: EdgeInsets.symmetric(vertical: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: utils.green50, borderRadius: BorderRadius.circular(25.r)),
      child: Shimmer.fromColors(
        baseColor: utils.baseShimmerColor,
        highlightColor: utils.highlightShimmerColor,
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
                      AppsFunction.lineShimmer(utils, 20.h, 30.w),
                      SizedBox(
                        width: 20.w,
                      ),
                      AppsFunction.lineShimmer(utils, 20.h, 45.w),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppsFunction.lineShimmer(
                    utils,
                    10.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppsFunction.lineShimmer(
                    utils,
                    10.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}