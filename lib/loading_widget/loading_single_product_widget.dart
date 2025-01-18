import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_colors.dart';
import '../res/app_function.dart';
import '../res/utils.dart';

class LoadingSingleProductWidget extends StatelessWidget {
  const LoadingSingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Container(
        height: 160.h,
        width: .9.sw,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black,
                spreadRadius: .05,
              )
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.r)),
        child: Shimmer.fromColors(
          baseColor: Utils.baseShimmerColor,
          highlightColor: Utils.highlightShimmerColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppsFunction.buildShimmerEffect(height: 130, width: 130),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        3,
                        (index) => AppsFunction.buildShimmerEffect(height: 20),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
