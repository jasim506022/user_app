import 'package:get/get.dart';
import 'package:user_app/controller/sign_in_controller.dart';
import 'package:user_app/repository/sign_in_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInRepository>(() => SignInRepository());

    Get.lazyPut<SignInController>(
        () => SignInController(signInRepository: Get.find<SignInRepository>()));
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
