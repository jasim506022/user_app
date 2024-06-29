import 'package:get/get.dart';
import 'package:user_app/repository/onboarding_repository.dart';
import '../repository/splash_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepository());
    Get.lazyPut<SplashRepository>(() => SplashRepository());
  }
}
