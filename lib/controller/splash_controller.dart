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
  SplashRepository repository;

  SplashController({required this.repository});

  @override
  void onInit() {
    _navigateToNextScreen();

    _configureUI();
    super.onInit();
  }

  // Logic for determining the next screen
  void _navigateToNextScreen() {
    try {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          var currentUser = repository.getCurrentUser();

          final route = currentUser != null
              ? AppRoutesName.mainPage
              : (AppConstant.isViewed != 0
                  ? AppRoutesName.onbordingScreen
                  : AppRoutesName.signInPage);

          Get.offNamed(route);
        },
      );
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: AppIcons.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: AppString.okay,
          ),
        );
      }
    }
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onClose();
  }

  void _configureUI() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive,
    );
  }
}
