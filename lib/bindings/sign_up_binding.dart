import 'package:get/get.dart';
import 'package:user_app/controller/sign_up_controller.dart';
import 'package:user_app/repository/sign_up_repository.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpRepository>(() => SignUpRepository());
    Get.lazyPut<SignUpController>(
        () => SignUpController(signUpRepository: Get.find<SignUpRepository>()));
  }
}
