import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_app/res/utils.dart';
import 'package:user_app/res/app_colors.dart';

class LoadingSingleProductWidget extends StatelessWidget {
  const LoadingSingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Container(
        height: 80.h, //160
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
          baseColor: utils.baseShimmerColor,
          highlightColor: utils.highlightShimmerColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70.h, // 140.h
                width: 140.w,
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.r),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                    color: const Color(0xfff6f5f1),
                    borderRadius: BorderRadius.circular(5.r)),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15.h,
                        width: 0.7.sw,
                        color: utils.widgetShimmerColor,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        height: 15.h,
                        width: 1.sw,
                        color: utils.widgetShimmerColor,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 15.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: utils.widgetShimmerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
