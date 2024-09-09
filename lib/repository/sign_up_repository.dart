import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/res/app_function.dart';

import '../data/response/app_data_exception.dart';
import '../data/service/data_firebase_service.dart';
import '../model/profilemodel.dart';

class SignUpRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<String> uploadUserImgeUrl({required File file}) async {
    try {
      return _dataFirebaseService.uploadUserImgeUrl(file: file);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<UserCredential> createUserWithEmilandPasword(
      {required String email, required String password}) {
    try {
      return _dataFirebaseService.createUserWithEmilandPasword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    } catch (e) {
      // AppsFunction.handleException(e);
      throw OthersException(e.toString());
    }
  }

  Future<void> uploadNewUserCreatingDocument(
      {required ProfileModel profileModel,
      required String firebaseDocument}) async {
    try {
      _dataFirebaseService.uploadNewUserCreatingDocument(
          profileModel: profileModel, firebaseDocument: firebaseDocument);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
