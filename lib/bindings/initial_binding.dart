import 'package:get/get.dart';
import 'package:user_app/repository/product_reposity.dart';
import 'package:user_app/repository/login_repository.dart';
import 'package:user_app/repository/onboarding_repository.dart';
import 'package:user_app/repository/profile_repository.dart';
import 'package:user_app/repository/signup_repository.dart';
import '../repository/splash_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepository());
    Get.lazyPut<SplashRepository>(() => SplashRepository());
    Get.lazyPut<LoginRepository>(() => LoginRepository());
    Get.lazyPut<SignUpRepository>(() => SignUpRepository());
    Get.lazyPut<ProductReposity>(() => ProductReposity());
    Get.lazyPut<ProfileRepository>(() => ProfileRepository());
  }
}
