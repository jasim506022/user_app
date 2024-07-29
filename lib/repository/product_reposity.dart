import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/service/data_firebase_service.dart';
import '../model/productsmodel.dart';

class ProductReposity {
  final _dataFirebaseService = DataFirebaseService();

  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
          {required String category}) =>
      _dataFirebaseService.popularProductSnapshot(category: category);

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
          {required String category}) =>
      _dataFirebaseService.productSnapshots(category: category);

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    return _dataFirebaseService.similarProductSnapshot(
        productModel: productModel);
  }
}
