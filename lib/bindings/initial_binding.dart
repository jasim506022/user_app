import 'package:get/get.dart';
import 'package:user_app/controller/product_controller.dart';

import '../controller/forget_password_controller.dart';
import '../controller/loading_controller.dart';
import '../controller/onboarding_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/select_image_controller.dart';
import '../controller/sign_in_controller.dart';
import '../controller/sign_up_controller.dart';
import '../controller/splash_controller.dart';
import '../repository/address_repository.dart';
import '../repository/forget_password_repository.dart';
import '../repository/onboarding_repository.dart';
import '../repository/product_reposity.dart';
import '../repository/profile_repository.dart';
import '../repository/select_image_repository.dart';
import '../repository/sign_in_repository.dart';
import '../repository/sign_up_repository.dart';
import '../repository/splash_repository.dart';
import '../controller/cart_product_counter_controller.dart';
import '../controller/category_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordRepository>(() => ForgetPasswordRepository());

    Get.lazyPut<SplashRepository>(() => SplashRepository());
    Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepository());
    Get.lazyPut<SignInRepository>(() => SignInRepository());
    Get.lazyPut<SignUpRepository>(() => SignUpRepository());
    Get.lazyPut<SelectImageRepository>(() => SelectImageRepository());
    Get.put<LoadingController>(LoadingController());

    // LoadingController loadingController = Get.put(LoadingController());

    Get.lazyPut<SplashController>(
        () => SplashController(repository: Get.find<SplashRepository>()));
    Get.lazyPut<OnBoardingController>(() => OnBoardingController(
        onBoardingRepository: Get.find<OnBoardingRepository>()));

    Get.lazyPut<SignInController>(
        () => SignInController(signInRepository: Get.find<SignInRepository>()));

    Get.lazyPut<ForgetPasswordController>(
        () => ForgetPasswordController(Get.find<ForgetPasswordRepository>()));

    Get.lazyPut<SelectImageController>(() => SelectImageController(
        selectImageRepository: Get.find<SelectImageRepository>()));

    Get.lazyPut<SelectImageController>(() => SelectImageController(
        selectImageRepository: Get.find<SelectImageRepository>()));

    Get.put<SignUpController>(
        SignUpController(signUpRepository: Get.find<SignUpRepository>()));

    Get.lazyPut<ProductReposity>(() => ProductReposity(), fenix: true);
    Get.lazyPut<AddressRepository>(() => AddressRepository());
    Get.lazyPut<ProfileRepository>(() => ProfileRepository(), fenix: true);

    Get.lazyPut<ProfileController>(
        () => ProfileController(repository: Get.find<ProfileRepository>()),
        fenix: true);
    Get.lazyPut<ProductController>(
        () => ProductController(Get.find<ProductReposity>()),
        fenix: true);

    Get.lazyPut<CartProductCountController>(() => CartProductCountController(),
        fenix: true);

         Get.lazyPut<CategoryController>(() => CategoryController(),
        fenix: true);
  }
}
