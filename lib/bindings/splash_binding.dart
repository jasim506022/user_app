import 'package:get/get.dart';

import '../controller/splash_controller.dart';
import '../repository/splash_repository.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashRepository>(() => SplashRepository());

    Get.lazyPut<SplashController>(
        () => SplashController(repository: Get.find<SplashRepository>()));
  }
}