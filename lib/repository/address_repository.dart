import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/res/app_function.dart';

import '../data/service/data_firebase_service.dart';
import '../model/address_model.dart';

class AddressRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<void> uploadOrUpdateAddress(
      {required AddressModel addressModel, bool? isUpdate = false}) async {
    try {
      await _dataFirebaseService.uploadOrUpdateAddress(
          addressModel: addressModel, isUpdate: isUpdate!);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }

  Future<void> deleteAddress({required String addressId}) async {
    try {
      await _dataFirebaseService.deleteAddress(addressId: addressId);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> addressSnapshot() {
    try {
      return _dataFirebaseService.addressSnapshot();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
