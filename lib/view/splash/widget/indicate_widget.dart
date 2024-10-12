import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../data/onboarding_list_data.dart';
import '../../../res/app_colors.dart';

class IndicateWidget extends StatelessWidget {
  const IndicateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var onBoardingController = Get.find<OnBoardingController>();
    return SizedBox(
      height: 12.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: OnBoardingListData.onboarddataList().length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  height: 10.w,
                  width: 10.w,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  decoration: BoxDecoration(
                      color: onBoardingController.currentIndex.value == index
                          ? AppColors.red
                          : AppColors.black,
                      shape: BoxShape.circle),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
