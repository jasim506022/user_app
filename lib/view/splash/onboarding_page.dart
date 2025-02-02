import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/onboarding_controller.dart';

import '../../data/onboarding_list_data.dart';
import '../../res/app_colors.dart';

import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import 'widget/onboarding_screen_content_widget.dart';

/// This screen displays the onboarding flow with multiple pages.
/// Users can swipe through onboarding pages or skip them using the 'Skip' button.

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingController = Get.find<OnboardingController>();
    final onboardingItems = OnBoardingListData.getOnboardingData();

    // Set the status bar style for better visibility
    _setStatusBarStyle();
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Skip Button: Navigates users to the next screen, marking onboarding as completed
          TextButton(
              onPressed: onboardingController.markOnboardingAsViewedAndNavigate,
              child: Text(AppString.skip,
                  style: AppsTextStyle.largeBoldText
                      .copyWith(color: AppColors.black))),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: PageView.builder(
            controller: onboardingController.pageController,
            itemCount: onboardingItems.length,
            onPageChanged: (index) => onboardingController.currentIndex(index),
            itemBuilder: (context, index) => OnboardingPageContentWidget(
                onboardingItem: onboardingItems[index])),
      ),
    );
  }

  /// Configures the status bar to have a light background with dark icons.
  void _setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.white, statusBarBrightness: Brightness.dark));
  }
}
