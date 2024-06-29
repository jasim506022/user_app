import 'package:get/get.dart';
import 'package:user_app/res/routes/routesname.dart';
import 'package:user_app/repository/onboarding_repository.dart';

class OnboardingController extends GetxController {
  final OnBoardingRepository onBoardingRepository;

  var currentIndex = 0.obs;

  OnboardingController({required this.onBoardingRepository});

  Future<void> completeOnboarding() async {
    await onBoardingRepository.setOnboardingViewed();
    Get.offNamed(RoutesName.signPage);
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
