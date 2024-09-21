import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/service/data_firebase_service.dart';
import '../res/app_function.dart';

class CartRepository {
  final _dataFirebaseService = DataFirebaseService();

  Stream<QuerySnapshot<Map<String, dynamic>>> cartSellerSnapshot() {
    try {
      return _dataFirebaseService.cartSellerSnapshot();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartProductSnapshot(
      {required String sellerId}) {
    try {
      return _dataFirebaseService.cartProductSnapshot(sellerId: sellerId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}