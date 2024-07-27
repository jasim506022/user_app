import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/service/data_firebase_service.dart';

class ProductReposity {
  final _dataFirebaseService = DataFirebaseService();

  Future<DocumentSnapshot<Map<String, dynamic>>>
      getUserInformationSnapshot() async {
    return await _dataFirebaseService.getUserInformationSnapshot();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
          {required String category}) =>
      _dataFirebaseService.popularProductSnapshot(category: category);

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
          {required String category}) =>
      _dataFirebaseService.productSnapshots(category: category);
}
