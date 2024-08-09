import 'package:get/get.dart';
import 'package:user_app/controller/login_controller.dart';
import 'package:user_app/repository/login_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(() => LoginRepository());

    Get.lazyPut<LoginController>(
        () => LoginController(Get.find<LoginRepository>()));
  }
}


/*
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(() => LoginRepository());
    Get.lazyPut<LoginController>(
        () => LoginController(Get.find<LoginRepository>()));
  }
}
*/
