import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../controller/onboarding_controller.dart';

import '../../data/onboarding_list_data.dart';
import '../../res/app_colors.dart';

import '../../res/apps_text_style.dart';
import 'widget/onboarding_screen_content_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    _setStatusBarStyle();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () => controller.markOnboardingAsViewedAndNavigate(),
              child: Text(
                AppString.skip,
                style: AppsTextStyle.largeBoldText
                    .copyWith(color: AppColors.black),
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: PageView.builder(
          controller: controller.pageController,
          itemCount: OnBoardingListData.onboarddataList().length,
          onPageChanged: (index) => controller.currentIndex(index),
          itemBuilder: (context, index) {
            var item = OnBoardingListData.onboarddataList()[index];
            return OnboardingPageContentWidget(onboardingItem: item);
          },
        ),
      ),
    );
  }

  void _setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.white, statusBarBrightness: Brightness.dark));
  }
}
