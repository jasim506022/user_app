import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/repository/profile_repository.dart';

import '../model/app_exception.dart';
import '../model/profilemodel.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/constants.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  SignUpRepository signUpRepository = SignUpRepository();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();

  var profileModel = ProfileModel().obs;
  var image = "".obs;
  var imageFile = Rx<File?>(null);
  var isChangeProfilePicture = false.obs;

  // DocumentSnapshot<Map<String, dynamic>> snapshot;

  ProfileController({required this.repository});

  // getImageFromGaller() async {
  //   final ImagePicker picker = ImagePicker();
  //   imageFile.value = await picker.pickImage(source: ImageSource.gallery);
  //   isChangeProfilePicture.value = true;
  // }

  Future<void> updateUserData({required Map<String, dynamic> map}) async {
    try {
      repository.updateUserData(map: map);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    }
  }

  void selectImage({required ImageSource imageSource}) async {
    try {
      //  imageFile.value =
      // await signUpRepository.captureImageSingle(imageSource: imageSource);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await repository.getUserInformationSnapshot();
  }

  Future<void> getUserInformationSnapshot() async {
    try {
      var snapshot = await repository.getUserInformationSnapshot();
      if (snapshot.exists) {
        profileModel.value = ProfileModel.fromMap(snapshot.data()!);
        if (profileModel.value.status == "approved") {
          final prefsTasks = [
            sharedPreference!.setString("uid", profileModel.value.uid!),
            sharedPreference!.setString("email", profileModel.value.email!),
            sharedPreference!.setString("name", profileModel.value.name!),
            sharedPreference!
                .setString("imageurl", profileModel.value.imageurl!),
            sharedPreference!.setString("phone", profileModel.value.phone!),
            sharedPreference!.setStringList("cartlist",
                profileModel.value.cartlist!.map((e) => e.toString()).toList())
          ];
          await Future.wait(prefsTasks);

          nameTEC.text = profileModel.value.name!;
          addressTEC.text = profileModel.value.address!;
          phoneTEC.text = profileModel.value.phone!;
          emailTEC.text = profileModel.value.email!;
          image.value = profileModel.value.imageurl!;
        } else {
          AppsFunction.flutterToast(msg: "User Doesn't Exist");
        }
      }
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    }
  }
}
