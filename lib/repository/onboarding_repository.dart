import 'package:user_app/res/app_string.dart';

import '../res/app_constant.dart';

class OnBoardingRepository {
  Future<void> setOnboardingViewed() async {
    await AppConstant.sharedPreference!
        .setInt(AppString.onBoardingSharedPre, 0);
  }
}
