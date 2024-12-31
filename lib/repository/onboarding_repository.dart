import '../res/app_constant.dart';
import '../res/constant/string_constant.dart';

class OnBoardingRepository {
  Future<void> setOnboardingViewed() async {
    await AppConstant.sharedPreference!
        .setInt(StringConstant.onBoardingSharedPre, 0);
  }
}
