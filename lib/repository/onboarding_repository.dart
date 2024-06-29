import 'package:shared_preferences/shared_preferences.dart';

import '../res/constants.dart';

class OnBoardingRepository {
  Future<void> setOnboardingViewed() async {
    sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference!.setInt(onBoardingSharedPre, 0);
  }
}
