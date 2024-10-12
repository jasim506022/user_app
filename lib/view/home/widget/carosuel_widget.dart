import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/carsolemodel.dart';
import '../../../res/app_colors.dart';
import '../../../res/apps_text_style.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.carouselModel,
  });

  final CarouselModel carouselModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: EdgeInsets.only(left: 24.w, bottom: 15.h, top: 15.h),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: carouselModel.color,
            borderRadius: BorderRadius.circular(15.r)),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                carouselModel.image,
                height: .19.sh,
                width: .19.sh,
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Cold Process",
                        style: AppsTextStyle.mediumText600.copyWith(
                          letterSpacing: .9,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                          text: " ${carouselModel.category}",
                          style: AppsTextStyle.mediumTextbold.copyWith(
                            letterSpacing: .9,
                            color: AppColors.greenColor,
                          )),
                    ],
                  ),
                ),
                Text(
                  carouselModel.title,
                  style: AppsTextStyle.largestText
                      .copyWith(fontSize: 24.sp, color: AppColors.black),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.greenColor, shape: BoxShape.circle),
                      child: Icon(
                        Icons.done,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      carouselModel.number.toUpperCase(),
                      style: AppsTextStyle.largeBoldText.copyWith(
                        letterSpacing: 1,
                        color: AppColors.greenColor,
                      ),
                    )
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Shop Now",
                      style: AppsTextStyle.largeBoldText.copyWith(
                        color: AppColors.black,
                        fontSize: 15.sp,
                        letterSpacing: 1,
                      )),
                )
              ],
            ),
          ],
        ));
  }
}
