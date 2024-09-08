import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/constant/string_constant.dart';

import '../data/service/data_firebase_service.dart';

class SplashRepository {
  final DataFirebaseService _dataFirebaseService = DataFirebaseService();

  Future<User?> getCurrentUser() async {
    try {
      return _dataFirebaseService.getCurrentUser();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<int?> getOnboardingStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(StringConstant.onBoardingSharedPre);
  }
}
