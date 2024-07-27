import 'package:get/get.dart';

import 'package:user_app/res/constants.dart';
import 'package:user_app/res/routes/routesname.dart';

import '../model/app_exception.dart';
import '../repository/login_repository.dart';
import '../res/app_function.dart';
import 'loading_controller.dart';

class LoginController extends GetxController {
  final LoginRepository _loginRepository;

  LoadingController loadingController = Get.put(LoadingController());

  LoginController(this._loginRepository);

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      loadingController.setLoading(true);

      await _loginRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      loadingController.setLoading(false);
      Get.offNamed(RoutesName.mainPage);

      globalMethod.flutterToast(msg: "Sign in Successfully");
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: "asset/image/fruits.png",
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    } finally {
      loadingController.setLoading(false);
    }
  }

  Future<void> signWithGoogle() async {
    try {
      AppsFunction.errorDialog(
        barrierDismissible: false,
        icon: "asset/image/fruits.png",
        title: "Loading for sign with Gmail \n Pleasing Waiting........",
      );

      var userCredentialGmail = await _loginRepository.signWithGoogle();

      if (userCredentialGmail != null) {
        if (await _loginRepository.userExists()) {
          Get.back();
          Get.offNamed(RoutesName.mainPage);
          globalMethod.flutterToast(msg: "Successfully Loging");
        } else {
          await _loginRepository.createUserGmail(
              user: userCredentialGmail.user!);
          Get.back();
          Get.offNamed(RoutesName.mainPage);
          globalMethod.flutterToast(msg: "Successfully Loging");
        }
      }
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: "asset/image/fruits.png",
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    }
  }
}
