import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/service/data_firebase_service.dart';
import '../res/app_function.dart';

class ProfileRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<DocumentSnapshot<Map<String, dynamic>>>
      getUserInformationSnapshot() async {
    try {
      return await _dataFirebaseService.getUserInformationSnapshot();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
