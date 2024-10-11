import 'package:get/get.dart';
import 'package:user_app/res/routes/routes_name.dart';
import 'package:user_app/repository/onboarding_repository.dart';

class OnBoardingController extends GetxController {
  final OnBoardingRepository onBoardingRepository;

  var currentIndex = 0.obs;

  OnBoardingController({required this.onBoardingRepository});

  Future<void> completeOnboarding() async {
    await onBoardingRepository.setOnboardingViewed();
    Get.offNamed(RoutesName.signPage);
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
