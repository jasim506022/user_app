import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../repository/sign_in_repository.dart';
import '../res/app_function.dart';
import '../res/app_asset/app_icons.dart';
import '../res/routes/routes_name.dart';
import 'loading_controller.dart';

class SignInController extends GetxController {
  final SignInRepository repository;
  var loadingController = Get.find<LoadingController>();

  final TextEditingController passwordET = TextEditingController();
  final TextEditingController emailET = TextEditingController();

  SignInController({required this.repository});

  @override
  void onClose() {
    passwordET.dispose();
    emailET.dispose();
    super.onClose();
  }

  void cleanTextField() {
    passwordET.clear();
    emailET.clear();
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!(await AppsFunction.verifyInternetStatus())) {
      try {
        loadingController.setLoading(true);

        await repository.signInWithEmailAndPassword(
          email: emailET.text,
          password: passwordET.text,
        );

        loadingController.setLoading(false);

        Get.offNamed(RoutesName.mainPage);
        cleanTextField();
        AppsFunction.flutterToast(msg: "Sign in Successfully");
      } catch (e) {
        if (e is AppException) {
          AppsFunction.errorDialog(
              icon: AppIcons.warningIcon,
              title: e.title!,
              content: e.message,
              buttonText: "Okay");
        }
      } finally {
        loadingController.setLoading(false);
      }
    }
  }

  Future<void> signWithGoogle() async {
    bool checkInternet = await AppsFunction.internetChecking();

    if (checkInternet) {
      AppsFunction.errorDialog(
          icon: AppIcons.warningIcon,
          title: "No Internet Connection",
          content: "Please check your internet settings and try again.",
          buttonText: "Okay");
    } else {
      try {
        AppsFunction.errorDialog(
          barrierDismissible: true,
          icon: AppIcons.warningIcon,
          title: "Loading for sign with Gmail \n Pleasing Waiting........",
        );

        var userCredentialGmail = await repository.signWithGoogle();

        if (userCredentialGmail != null) {
          Get.back();
          if (await repository.userExists()) {
            Get.offNamed(RoutesName.mainPage);
            AppsFunction.flutterToast(msg: "Successfully Loging");
          } else {
            await repository.createUserGmail(user: userCredentialGmail.user!);

            Get.offNamed(RoutesName.mainPage);
            AppsFunction.flutterToast(msg: "Successfully Loging");
          }
        }
      } catch (e) {
        Get.back();
        if (e is AppException) {
          AppsFunction.errorDialog(
              icon: AppIcons.warningIcon,
              title: e.title!,
              content: e.message,
              buttonText: "Okay");
        }
      }
    }
  }
}
