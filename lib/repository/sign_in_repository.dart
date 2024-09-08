import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/data/service/data_firebase_service.dart';

import '../res/app_function.dart';

class SignInRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _dataFirebaseService.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<UserCredential?> signWithGoogle() async {
    try {
      return await _dataFirebaseService.signWithGoogle();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<bool> userExists() async {
    try {
      return await _dataFirebaseService.userExists();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<void> createUserGmail({required User user}) async {
    try {
      await _dataFirebaseService.createUserGmail(user: user);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}

class CartRepository {
  final _dataFirebaseService = DataFirebaseService();

  Stream<QuerySnapshot<Map<String, dynamic>>> cartSellerSnapshot() {
    try {
      return _dataFirebaseService.cartSellerSnapshot();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }

    //
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartProductSnapshot(
      {required String sellerId}) {
    try {
      return _dataFirebaseService.cartProductSnapshot(sellerId: sellerId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
    //
  }
}
