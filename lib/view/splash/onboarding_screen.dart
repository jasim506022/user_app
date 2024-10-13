import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/onboarding_controller.dart';

import '../../data/onboarding_list_data.dart';
import '../../res/app_colors.dart';

import '../../res/apps_text_style.dart';
import 'widget/onbarding_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    var onBoardingController = Get.find<OnBoardingController>();

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0.0,
          actions: [
            TextButton(
                onPressed: () {
                  onBoardingController.completeOnboarding();
                },
                child: Text(
                  "Skip",
                  style: AppsTextStyle.largeText.copyWith(),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: PageView.builder(
            controller: onBoardingController.pageController,
            itemCount: OnBoardingListData.onboarddataList().length,
            onPageChanged: (value) {
              onBoardingController.updateIndex(value);
            },
            itemBuilder: (context, index) {
              var onboardModel = OnBoardingListData.onboarddataList()[index];
              return OnBoardingItem(
                index: index,
                onboardModel: onboardModel,
              );
            },
          ),
        ));
  }
}
