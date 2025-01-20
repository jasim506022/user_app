import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_constant.dart';
import 'package:user_app/res/routes/routes_name.dart';

import '../data/onboarding_list_data.dart';
import '../res/app_string.dart';

/*
class OnBoardingController extends GetxController {
  final OnBoardingRepository repository;

  final PageController pageController = PageController(initialPage: 0);

  @override
  void onClose() {
    pageController.dispose(); // Dispose the PageController when not needed
    super.onClose();
  }

  var currentIndex = 0.obs;

  OnBoardingController({required this.repository});

  Future<void> completeOnboarding() async {
    await repository.setOnboardingViewed();
    Get.offNamed(AppRoutesName.signInPage);
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < 2) {
      // Assuming 3 onboarding pages
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding(); // Complete onboarding when on the last page
    }
  }
}

*/

class OnboardingController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  var currentIndex = 0.obs;

  /// Marks the onboarding as viewed in shared preferences and navigates to the sign-in page
  void markOnboardingAsViewedAndNavigate() {
    AppConstant.isViewed = 0;
    AppConstant.sharedPreference!
        .setInt(AppString.onBoardingShareKey, AppConstant.isViewed!);
    Get.offNamed(AppRoutesName.signInPage);
  }

  /// Navigates to the next page in the onboarding sequence
  void navigateToNextPageOrSkip() {
    if (currentIndex.value == OnBoardingListData.onboarddataList().length - 1) {
      markOnboardingAsViewedAndNavigate();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
