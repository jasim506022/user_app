import 'package:get/get.dart';
import 'package:user_app/controller/forget_password_controller.dart';
import 'package:user_app/controller/onboarding_controller.dart';
import 'package:user_app/controller/select_image_controller.dart';
import 'package:user_app/controller/sign_in_controller.dart';
import 'package:user_app/controller/sign_up_controller.dart';
import 'package:user_app/controller/splash_controller.dart';
import 'package:user_app/repository/address_repository.dart';
import 'package:user_app/repository/forget_password_repository.dart';
import 'package:user_app/repository/select_image_repository.dart';
import 'package:user_app/repository/sign_in_repository.dart';
import 'package:user_app/repository/sign_up_repository.dart';

import '../controller/loading_controller.dart';
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
        () => SignInController( signInRepository:  Get.find<SignInRepository>()));

    Get.lazyPut<ForgetPasswordController>(
        () => ForgetPasswordController( Get.find<ForgetPasswordRepository>()));

    Get.lazyPut<SelectImageController>(() => SelectImageController(
        selectImageRepository: Get.find<SelectImageRepository>()));

        Get.lazyPut<SelectImageController>(() => SelectImageController(
        selectImageRepository: Get.find<SelectImageRepository>()));

    Get.put<SignUpController>(
        SignUpController(signUpRepository: Get.find<SignUpRepository>()));

    Get.lazyPut<ProductReposity>(() => ProductReposity());
    Get.lazyPut<AddressRepository>(() => AddressRepository());
    Get.lazyPut<ProfileRepository>(() => ProfileRepository());
  }
}
