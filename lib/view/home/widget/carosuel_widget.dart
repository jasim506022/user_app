import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/carsole_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
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
        width: 1.sw,
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

  /// Builds the main content of the carousel, such as the title and category.

  Column _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppString.coldProcess,
                style: AppsTextStyle.mediumNormalText
                    .copyWith(letterSpacing: .9, color: AppColors.black),
              ),
              TextSpan(
                  text: " ${carouselModel.category}",
                  style: AppsTextStyle.bodyTextStyle.copyWith(
                    letterSpacing: .9,
                    color: AppColors.accentGreen,
                  )),
            ],
          ),
        ),
        Text(
          carouselModel.title,
          style: AppsTextStyle.largeTitleTextStyle
              .copyWith(color: AppColors.black),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.accentGreen, shape: BoxShape.circle),
              child: Icon(
                Icons.done,
                color: AppColors.white,
              ),
            ),
            AppsFunction.horizontalSpacing(10),
            Text(
              carouselModel.number.toUpperCase(),
              style: AppsTextStyle.largeBoldText.copyWith(
                letterSpacing: 1,
                color: AppColors.accentGreen,
              ),
            )
          ],
        ),

        /// Builds the "Shop Now" button.
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r)),
          child: Text(AppString.shopNow,
              style: AppsTextStyle.buttonTextStyle
                  .copyWith(color: AppColors.black)),
        )
      ],
    );
  }

  /// Builds the image positioned at the bottom-right corner.

  Positioned _buildImage() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Opacity(
        opacity: .6,
        child: Image.asset(
          carouselModel.image,
          height: 160.h,
          width: 160.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
