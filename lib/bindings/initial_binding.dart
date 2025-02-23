import 'package:get/get.dart';
import 'package:user_app/controller/address_controller.dart';
import 'package:user_app/controller/bill_controller.dart';
import 'package:user_app/controller/cart_controller.dart';
import 'package:user_app/controller/order_controller.dart';
import 'package:user_app/controller/product_controller.dart';
import 'package:user_app/repository/bill_repository.dart';
import 'package:user_app/repository/cart_repository.dart';
import 'package:user_app/repository/order_repository.dart';

import '../controller/auth_controller.dart';
import '../controller/forget_password_controller.dart';
import '../controller/loading_controller.dart';

import '../controller/profile_controller.dart';
import '../controller/search_controller.dart';
import '../controller/select_image_controller.dart';
import '../controller/sign_in_controller.dart';
import '../controller/sign_up_controller.dart';

import '../repository/address_repository.dart';
import '../repository/auth_reposity.dart';
import '../repository/forget_password_repository.dart';
import '../repository/product_reposity.dart';
import '../repository/profile_repository.dart';
import '../repository/select_image_repository.dart';
import '../repository/sign_in_repository.dart';
import '../repository/sign_up_repository.dart';
import '../repository/splash_repository.dart';
import '../controller/category_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordRepository>(() => ForgetPasswordRepository());

    Get.lazyPut<SplashRepository>(() => SplashRepository());
    Get.lazyPut<SignInRepository>(() => SignInRepository());
    Get.lazyPut<SignUpRepository>(() => SignUpRepository());
    Get.lazyPut<BillRepository>(() => BillRepository(), fenix: true);
    Get.lazyPut<SelectImageRepository>(() => SelectImageRepository());
    Get.put<LoadingController>(LoadingController());

    Get.lazyPut<OrderRepository>(() => OrderRepository(), fenix: true);

    // LoadingController loadingController = Get.put(LoadingController());

    Get.lazyPut<AuthReposity>(() => AuthReposity(), fenix: true);

    Get.lazyPut<AuthController>(
        () => AuthController(repository: Get.find<AuthReposity>()),
        fenix: true);

    // Get.lazyPut<SignInController>(
    //     () => SignInController(repository: Get.find<SignInRepository>()));

    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController(
        repository: Get.find<ForgetPasswordRepository>()));

    Get.lazyPut<SelectImageController>(() =>
        SelectImageController(repository: Get.find<SelectImageRepository>()));

    Get.lazyPut<SelectImageController>(() =>
        SelectImageController(repository: Get.find<SelectImageRepository>()));

    Get.put<SignUpController>(
        SignUpController(repository: Get.find<SignUpRepository>()));

    Get.lazyPut<ProductReposity>(() => ProductReposity(), fenix: true);
    Get.lazyPut<CartRepository>(() => CartRepository(), fenix: true);
    Get.lazyPut<AddressRepository>(() => AddressRepository(), fenix: true);
    Get.lazyPut<ProfileRepository>(() => ProfileRepository(), fenix: true);

    Get.lazyPut<ProfileController>(
        () => ProfileController(repository: Get.find<ProfileRepository>()),
        fenix: true);
    Get.lazyPut<ProductController>(
        () => ProductController(repository: Get.find<ProductReposity>()),
        fenix: true);

    Get.lazyPut<AddressController>(
        () => AddressController(Get.find<AddressRepository>()),
        fenix: true);

    // Get.lazyPut<CartProductCountController>(() => CartProductCountController(),
    //     fenix: true);

    Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
    Get.lazyPut<CartController>(
        () => CartController(repository: Get.find<CartRepository>()),
        fenix: true);
    Get.lazyPut<BillController>(
        () => BillController(repository: Get.find<BillRepository>()),
        fenix: true);
    Get.lazyPut<OrderController>(
        () => OrderController(Get.find<OrderRepository>()),
        fenix: true);

    Get.lazyPut<ProductSearchController>(() => ProductSearchController());
  }
}
