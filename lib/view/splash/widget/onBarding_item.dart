import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../model/onboardmodel.dart';
import '../../../res/app_colors.dart';
import '../../../res/apps_text_style.dart';
import 'indicate_widget.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem(
      {super.key, required this.onboardModel, required this.index});
  final OnboardModel onboardModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    var onBoardingController = Get.find<OnBoardingController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          onboardModel.photo,
          height: 0.35.sh,
          fit: BoxFit.fill,
        ),
        const IndicateWidget(),
        Text(
          onboardModel.title,
          textAlign: TextAlign.center,
          style: AppsTextStyle.onBoardTextStyle,
        ),
        Text(onboardModel.description,
            textAlign: TextAlign.center,
            style: AppsTextStyle.onBoardTextStyle
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
        InkWell(
          onTap: () {
            onBoardingController.nextPage();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.w),
            decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(15.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  index == 2 ? "Finish" : "Next",
                  style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
                SizedBox(
                  width: 18.w,
                ),
                Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}