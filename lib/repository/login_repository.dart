import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/data/response/app_data_exception.dart';
import 'package:user_app/data/service/data_firebase_service.dart';

class LoginRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _dataFirebaseService.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      handleException(e);
      rethrow;
    }
  }

  Future<UserCredential?> signWithGoogle() async {
    try {
      return await _dataFirebaseService.signWithGoogle();
    } catch (e) {
      handleException(e);
      rethrow;
    }
  }

  Future<bool> userExists() async {
    try {
      return await _dataFirebaseService.userExists();
    } catch (e) {
      handleException(e);
      rethrow;
    }
  }

  Future<void> createUserGmail({required User user}) async {
    try {
      await _dataFirebaseService.createUserGmail(user: user);
    } catch (e) {
      handleException(e);
    }
  }

  void handleException(Object e) {
    if (e is FirebaseAuthException) {
      throw FirebaseAuthExceptions(e);
    } else if (e is SocketException) {
      throw InternetException(e.toString());
    } else {
      throw OthersException(e.toString());
    }
  }
}
