import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../data/service/data_firebase_service.dart';
import '../model/profilemodel.dart';

class SignUpRepository {
  final ImagePicker _imagepicker = ImagePicker();

  final _dataFirebaseService = DataFirebaseService();

  Future<File> captureImageSingle({required ImageSource imageSource}) async {
    XFile? captureImage = await _imagepicker.pickImage(source: imageSource);
    return File(captureImage!.path);
  }

  Future<String> uploadUserImgeUrl({required File file}) async {
    return _dataFirebaseService.uploadUserImgeUrl(file: file);
  }

  Future<UserCredential> createUserWithEmilandPasword(
      {required String email, required String password}) {
    return _dataFirebaseService.createUserWithEmilandPasword(
        email: email, password: password);
  }

  Future<void> uploadNewUserCreatingDocument(
      {required ProfileModel profileModel,
      required String firebaseDocument}) async {
    _dataFirebaseService.uploadNewUserCreatingDocument(
        profileModel: profileModel, firebaseDocument: firebaseDocument);
  }
}
