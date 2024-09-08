import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/service/data_firebase_service.dart';
import '../res/app_function.dart';

class OrderRepository {
  final _dataFirebaseService = DataFirebaseService();

  Stream<QuerySnapshot<Map<String, dynamic>>> allOrderSnapshots() {
    try {
      return _dataFirebaseService.allOrderSnapshots();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<dynamic> itemIDDetails}) async {
    try {
      return await _dataFirebaseService.orderProductSnapshots(
          itemIDDetails: itemIDDetails);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
