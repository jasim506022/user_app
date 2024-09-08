import 'package:get/get.dart';
import 'package:user_app/controller/onboarding_controller.dart';
import 'package:user_app/controller/splash_controller.dart';
import 'package:user_app/repository/address_repository.dart';
import 'package:user_app/repository/forget_password_repository.dart';

import '../repository/onboarding_repository.dart';
import '../repository/product_reposity.dart';
import '../repository/profile_repository.dart';
import '../repository/splash_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordRepository>(() => ForgetPasswordRepository());
    Get.lazyPut<SplashRepository>(() => SplashRepository());
    Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepository());

    Get.lazyPut<SplashController>(
        () => SplashController(repository: Get.find<SplashRepository>()));
    Get.lazyPut<OnBoardingController>(() => OnBoardingController(
        onBoardingRepository: Get.find<OnBoardingRepository>()));

    Get.lazyPut<ProductReposity>(() => ProductReposity());
    Get.lazyPut<AddressRepository>(() => AddressRepository());
    Get.lazyPut<ProfileRepository>(() => ProfileRepository());
  }
}
