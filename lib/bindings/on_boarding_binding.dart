
import 'package:get/get.dart';
import 'package:user_app/controller/onboarding_controller.dart';
import 'package:user_app/repository/onboarding_repository.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepository());

    Get.lazyPut<OnBoardingController>(
        () => OnBoardingController(repository: Get.find<OnBoardingRepository>()));
  }
}