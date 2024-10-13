import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../repository/forget_password_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/routes/routes_name.dart';
import 'loading_controller.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController emailET = TextEditingController();

  @override
  void onClose() {
    emailET.dispose();
    super.onClose();
  }

  final ForgetPasswordRepository repository;

  LoadingController loadingController = Get.find();

  ForgetPasswordController({required this.repository});

  forgetPasswordButton() async {
    loadingController.setLoading(true);
    bool checkInternet = await AppsFunction.internetChecking();

    if (checkInternet) {
      AppsFunction.errorDialog(
          icon: IconAsset.warningIcon,
          title: "No Internet Connection",
          content: "Please check your internet settings and try again.",
          buttonText: "Okay");
    } else {
      try {
        repository.forgetPasswordSnapshot(email: emailET.text.trim());
        AppsFunction.flutterToast(msg: "Sending a mail. Please Check ur Email");
        Get.toNamed(RoutesName.signPage);
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
}
