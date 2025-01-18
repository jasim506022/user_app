import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../repository/splash_repository.dart';
import '../res/app_constant.dart';
import '../res/app_string.dart';
import '../res/app_asset/app_icons.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';

class SplashController extends GetxController {
  final SplashRepository repository;

  SplashController({required this.repository});

  @override
  void onInit() {
    navigateToNextPage();
    super.onInit();
  }

  void navigateToNextPage() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      var currentUser = await repository.getCurrentUser();

      AppConstant.isViewed = await repository.getOnboardingStatus();

      if (currentUser != null) {
        Get.offNamed(AppRoutesName.mainPage);
      } else {
        Get.offNamed(AppConstant.isViewed != 0
            ? AppRoutesName.onbordingScreen
            : AppRoutesName.signInPage);
      }
    } catch (e) {
      if (e is AppException) {
        Get.dialog(const ErrorDialogWidget(
            barrierDismissible: true,
            icon: AppIcons.warningIcon,
            title: "e.title!",
            content: "e.message",
            buttonText: AppString.okay));
      }
      Get.offNamed(AppRoutesName.signInPage);
    }
  }

  @override
  void dispose() {
    // Reset system UI mode to manual when navigating away
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
}
