import 'package:user_app/res/app_function.dart';

import '../data/service/data_firebase_service.dart';

class ForgetPasswordRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<void> forgetPasswordSnapshot({required String email}) async {
    try {
      await _dataFirebaseService.forgetPasswordSnapshot(email: email);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}
