import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../repository/sign_in_repository.dart';
import '../res/app_function.dart';
import '../res/app_asset/app_icons.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../res/network_utili.dart';
import '../widget/error_dialog_widget.dart';
import '../widget/show_alert_dialog_widget.dart';
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

  Future<void> handleBackNavigaion(bool didPop) async {
    if (didPop) return;

    final bool shouldPop = await Get.dialog(CustomAlertDialogWidget(
      icon: Icons.question_mark_rounded,
      title: AppString.exit,
      subTitle: AppString.exitMessage,
      yesOnPress: () => Get.back(result: true),
      noOnPress: () => Get.back(result: false),
    ));

    if (shouldPop) {
      SystemNavigator.pop();
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!(await NetworkUtili.verifyInternetStatus())) {
      try {
        loadingController.setLoading(true);

        await repository.signInWithEmailAndPassword(
          email: emailET.text,
          password: passwordET.text,
        );

        loadingController.setLoading(false);

        Get.offNamed(AppRoutesName.mainPage);
        cleanTextField();
        AppsFunction.showToast(msg: "Sign in Successfully");
      } catch (e) {
        if (e is AppException) {
          Get.dialog(
            ErrorDialogWidget(
              icon: AppIcons.warningIcon,
              title: "e.title!",
              content: e.message,
              buttonText: AppString.okay,
            ),
          );
          // AppsFunction.errorDialog(
          //     icon: AppIcons.warningIcon,
          //     title: e.title!,
          //     content: e.message,
          //     buttonText: "Okay");
        }
      } finally {
        loadingController.setLoading(false);
      }
    }
  }

  Future<void> signWithGoogle() async {
    // bool checkInternet = await AppsFunction.internetChecking();

    // if (checkInternet) {
    //   AppsFunction.errorDialog(
    //       icon: AppIcons.warningIcon,
    //       title: "No Internet Connection",
    //       content: "Please check your internet settings and try again.",
    //       buttonText: "Okay");
    // } else {

    try {
      Get.dialog(
        const ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: "e.title!",
          content: "e.message",
          buttonText: AppString.okay,
        ),
      );

      // AppsFunction.errorDialog(
      //   barrierDismissible: true,
      //   icon: AppIcons.warningIcon,
      //   title: "Loading for sign with Gmail \n Pleasing Waiting........",
      // );

      var userCredentialGmail = await repository.signWithGoogle();

      if (userCredentialGmail != null) {
        Get.back();
        if (await repository.userExists()) {
          Get.offNamed(AppRoutesName.mainPage);
          AppsFunction.showToast(msg: "Successfully Loging");
        } else {
          await repository.createUserGmail(user: userCredentialGmail.user!);

          Get.offNamed(AppRoutesName.mainPage);
          AppsFunction.showToast(msg: "Successfully Loging");
        }
      }
    } catch (e) {
      Get.back();
      if (e is AppException) {
        //   AppsFunction.errorDialog(
        //       icon: AppIcons.warningIcon,
        //       title: e.title!,
        //       content: e.message,
        //       buttonText: "Okay");
        // }

        Get.dialog(
          ErrorDialogWidget(
            icon: AppIcons.warningIcon,
            title: "e.title!",
            content: e.message,
            buttonText: AppString.okay,
          ),
        );
      }

      // }
    }
  }
}
