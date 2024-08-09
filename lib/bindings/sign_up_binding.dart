import 'package:get/get.dart';
import 'package:user_app/controller/signup_controller.dart';
import 'package:user_app/repository/signup_repository.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpRepository>(() => SignUpRepository());
    Get.lazyPut<SignUpController>(
        () => SignUpController(Get.find<SignUpRepository>()));
  }
}
