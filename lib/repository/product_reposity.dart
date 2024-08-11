import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/service/data_firebase_service.dart';
import '../model/productsmodel.dart';
import '../res/app_function.dart';

class ProductReposity {
  final _dataFirebaseService = DataFirebaseService();

  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
      {required String category}) {
    try {
      return _dataFirebaseService.popularProductSnapshot(category: category);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
      {required String category}) {
    try {
      return _dataFirebaseService.productSnapshots(category: category);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    try {
      return _dataFirebaseService.similarProductSnapshot(
          productModel: productModel);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
