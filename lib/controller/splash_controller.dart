import 'package:get/get.dart';
import 'package:user_app/res/routes/routes_name.dart';

import '../repository/splash_repository.dart';
import '../res/constants.dart';

class SplashController extends GetxController {
  final SplashRepository repository;

  SplashController({required this.repository});

  @override
  void onInit() {
    navigateToNextPage();
    super.onInit();
  }

  void navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));

    var currentUser = await repository.getCurrentUser();

    isviewed = await repository.getOnboardingStatus();

    if (currentUser != null) {
      Get.offNamed(RoutesName.mainPage);
    } else {
      if (isviewed != 0) {
        Get.offNamed(RoutesName.onBaordingPage);
      } else {
        Get.offNamed(RoutesName.signPage);
      }
    }
  }
}
