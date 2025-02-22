import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/app_string.dart';

import '../data/service/data_firebase_service.dart';
import '../res/app_constant.dart';

class SplashRepository {
  final DataFirebaseService _dataFirebaseService = DataFirebaseService();

  User? getCurrentUser() {
    try {
      return _dataFirebaseService.getCurrentUser();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<int?> getOnboardingStatus() async {
    return AppConstant.sharedPreference!.getInt(AppString.onBoardingSharedPre);
  }
}
