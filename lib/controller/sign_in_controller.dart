import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../repository/sign_in_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/routes/routesname.dart';
import 'loading_controller.dart';

class SignInController extends GetxController {
  final TextEditingController passwordET = TextEditingController();
  final TextEditingController emailET = TextEditingController();



  final SignInRepository _loginRepository;

  LoadingController loadingController = Get.put(LoadingController());

  SignInController(this._loginRepository);

  @override
  void onClose() {
    passwordET.dispose();
    emailET.dispose();
    super.onClose();
  }

  Future<void> signInWithEmailAndPassword() async {
   

    bool checkInternet = await AppsFunction.internetChecking();

    if (checkInternet) {
      AppsFunction.errorDialog(
          icon: IconAsset.warningIcon,
          title: "No Internet Connection",
          content: "Please check your internet settings and try again.",
          buttonText: "Okay");
    } else {
      try {
        loadingController.setLoading(true);

        await _loginRepository.signInWithEmailAndPassword(
          email: emailET.text,
          password: passwordET.text,
        );

        loadingController.setLoading(false);
        Get.offNamed(RoutesName.mainPage);

        AppsFunction.flutterToast(msg: "Sign in Successfully");
      } catch (e) {
        if (e is AppException) {
          AppsFunction.errorDialog(
              icon: IconAsset.warningIcon,
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
          icon: IconAsset.warningIcon,
          title: "No Internet Connection",
          content: "Please check your internet settings and try again.",
          buttonText: "Okay");
    } else {
      try {
        AppsFunction.errorDialog(
          barrierDismissible: true,
          icon: IconAsset.warningIcon,
          title: "Loading for sign with Gmail \n Pleasing Waiting........",
        );

        var userCredentialGmail = await _loginRepository.signWithGoogle();

        if (userCredentialGmail != null) {
          Get.back();
          if (await _loginRepository.userExists()) {
            Get.offNamed(RoutesName.mainPage);
            AppsFunction.flutterToast(msg: "Successfully Loging");
          } else {
            await _loginRepository.createUserGmail(
                user: userCredentialGmail.user!);

            Get.offNamed(RoutesName.mainPage);
            AppsFunction.flutterToast(msg: "Successfully Loging");
          }
        }
      } catch (e) {
        Get.back();
        if (e is AppException) {
          AppsFunction.errorDialog(
              icon: IconAsset.warningIcon,
              title: e.title!,
              content: e.message,
              buttonText: "Okay");
        }
      }
    }
  }
}
