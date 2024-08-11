import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/res/app_function.dart';

import '../data/service/data_firebase_service.dart';
import '../model/profilemodel.dart';

class SignUpRepository {
  final ImagePicker _imagepicker = ImagePicker();

  final _dataFirebaseService = DataFirebaseService();

  Future<File> captureImageSingle({required ImageSource imageSource}) async {
    try {
      XFile? captureImage = await _imagepicker.pickImage(source: imageSource);
      if (captureImage == null) {
        AppsFunction.flutterToast(
            msg: "No image selected or operation was canceled.");
      }
      return File(captureImage!.path);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

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
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
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
