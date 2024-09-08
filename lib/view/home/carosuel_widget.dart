

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/carsolemodel.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';

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
        padding: EdgeInsets.only(
            left: Get.width * .055,
            bottom: Get.height * .02,
            top: Get.height * .02),
        margin: EdgeInsets.symmetric(horizontal: Get.width * .022),
        decoration: BoxDecoration(
            color: carouselModel.color, borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                carouselModel.image,
                height: Get.height * .19,
                width: Get.height * .19,
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
                        style: Textstyle.mediumText600.copyWith(
                          letterSpacing: .9,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                          text: " ${carouselModel.category}",
                          style: Textstyle.mediumTextbold.copyWith(
                            letterSpacing: .9,
                            color: AppColors.greenColor,
                          )),
                    ],
                  ),
                ),
                Text(
                  carouselModel.title,
                  style: Textstyle.largestText
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
                      style: Textstyle.largeBoldText.copyWith(
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
                      style: Textstyle.largeBoldText.copyWith(
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
