import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/app_exception.dart';
import '../model/profilemodel.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/routes/routesname.dart';
import 'loading_controller.dart';

class SignUpController extends GetxController {
  final TextEditingController phontET = TextEditingController();
  final TextEditingController nameET = TextEditingController();
  final TextEditingController emailET = TextEditingController();
  final TextEditingController passwordET = TextEditingController();
  final TextEditingController confirmpasswordET = TextEditingController();

  final SignUpRepository _signUpRepository;

  LoadingController loadingController = Get.put(LoadingController());

  SignUpController(this._signUpRepository);

  var selectPhoto = Rx<File?>(null);

  @override
  void onClose() {
    passwordET.dispose();
    emailET.dispose();
    phontET.dispose();
    confirmpasswordET.dispose();
    nameET.dispose();
    super.onClose();
  }

  void selectImage({required ImageSource imageSource}) async {
    try {
      var image =
          await _signUpRepository.captureImageSingle(imageSource: imageSource);
      selectPhoto.value = image;
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

  Future<void> createNewUserButton() async {
    if (passwordET.text.trim() != confirmpasswordET.text.trim()) {
      AppsFunction.errorDialog(
          icon: IconAsset.warningIcon,
          title: "Please Check Password",
          content:
              "Password and Confirm Password Is Not Match. Please Check Password",
          buttonText: "Okay");
      return;
    }

    bool checkInternet = await AppsFunction.internetChecking();

    if (checkInternet) {
      AppsFunction.errorDialog(
          icon: IconAsset.warningIcon,
          title: "No Internet Connection",
          content: "Please check your internet settings and try again.",
          buttonText: "Okay");
    } else {
      try {
        loadingController.setLoading(true);
        var userProfileImageUrl =
            await _signUpRepository.uploadUserImgeUrl(file: selectPhoto.value!);

        var user = await _signUpRepository.createUserWithEmilandPasword(
            email: emailET.text.trim(), password: passwordET.text.trim());

        ProfileModel profileModel = ProfileModel(
          address: "",
          cartlist: ["initial"],
          email: emailET.text.trim(),
          name: nameET.text.trim(),
          imageurl: userProfileImageUrl,
          phone: "0${phontET.text.trim()}",
          status: "approved",
          uid: user.user!.uid,
        );

        _signUpRepository.uploadNewUserCreatingDocument(
            profileModel: profileModel, firebaseDocument: user.user!.uid);
        Get.offNamed(RoutesName.signPage);
        AppsFunction.flutterToast(msg: "Sign in Successfully");
      } catch (e) {
        if (e is AppException) {
          AppsFunction.errorDialog(
              icon: "asset/image/fruits.png",
              title: e.title!,
              content: e.message,
              buttonText: "Okay");
        }
      } finally {
        loadingController.setLoading(false);
      }
    }
  }
}
