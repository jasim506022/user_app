
import '../res/constant/string_constant.dart';
import '../res/constants.dart';

class OnBoardingRepository {
  
  Future<void> setOnboardingViewed() async {
    await sharedPreference!.setInt(StringConstant.onBoardingSharedPre, 0);
  }
}
