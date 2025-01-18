import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/routes/routes_name.dart';
import 'package:user_app/repository/onboarding_repository.dart';

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
