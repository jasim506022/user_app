

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/service/data_firebase_service.dart';

class ProfileRepository{
final _dataFirebaseService = DataFirebaseService();
    Future<DocumentSnapshot<Map<String, dynamic>>>
      getUserInformationSnapshot() async {
    return await _dataFirebaseService.getUserInformationSnapshot();
  }
}