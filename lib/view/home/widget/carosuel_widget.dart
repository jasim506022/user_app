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
            _buildContent(),
            _buildImage(),
          ],
        ));
  }

  Column _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Cold Process",
                style: AppsTextStyle.bodyTextStyle.copyWith(
                  letterSpacing: .9,
                ),
              ),
              TextSpan(
                  text: " ${carouselModel.category}",
                  style: AppsTextStyle.boldBodyTextStyle.copyWith(
                    letterSpacing: .9,
                    color: AppColors.greenColor,
                  )),
            ],
          ),
        ),
        Text(
          carouselModel.title,
          style: AppsTextStyle.largeTitleTextStyle,
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Text("Shop Now",
              style: AppsTextStyle.buttonTextStyle
                  .copyWith(color: AppColors.black)),
        )
      ],
    );
  }

  Positioned _buildImage() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Opacity(
        opacity: .6,
        child: Image.asset(
          carouselModel.image,
          height: .19.sh,
          width: .19.sh,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
