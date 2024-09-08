import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/res/constant/string_constant.dart';

import '../res/constants.dart';

class OnBoardingRepository {
  
  Future<void> setOnboardingViewed() async {
    sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference!.setInt(StringConstant.onBoardingSharedPre, 0);
  }
}
