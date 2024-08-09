import 'package:get/get.dart';



class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginRepository>(() => LoginRepository());
    // Get.lazyPut<SignUpRepository>(() => SignUpRepository());
//is it
    // Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepository());
    // Get.lazyPut<SplashRepository>(() => SplashRepository());
    // Get.lazyPut<LoginRepository>(() => LoginRepository());
    // Get.lazyPut<LoginController>(
    //   () => LoginController(Get.find<LoginRepository>()),
    // );
    // Get.lazyPut<SignUpController>(
    //     () => SignUpController(Get.find<SignUpRepository>()));
    // Get.lazyPut<SignUpController>(
    //   () => SignUpController(Get.find<SignUpRepository>()),
    // );
    // Get.lazyPut<SignUpRepository>(() => SignUpRepository());
// is
    // Get.lazyPut<ProductReposity>(() => ProductReposity());
    // Get.lazyPut<ProfileRepository>(() => ProfileRepository());
  }
}
