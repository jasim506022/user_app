import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/profilemodel.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/routes/routes_name.dart';
import 'loading_controller.dart';
import 'select_image_controller.dart';

class SignUpController extends GetxController {
  final SignUpRepository signUpRepository;
  LoadingController loadingController = Get.find();
  SelectImageController selectImageController = Get.find();

  final TextEditingController phontET = TextEditingController();
  final TextEditingController nameET = TextEditingController();
  final TextEditingController emailET = TextEditingController();
  final TextEditingController passwordET = TextEditingController();
  final TextEditingController confirmpasswordET = TextEditingController();

  SignUpController({required this.signUpRepository});

  @override
  void onClose() {
    passwordET.dispose();
    emailET.dispose();
    emailET.text = "";
    phontET.dispose();
    confirmpasswordET.dispose();
    nameET.dispose();
  }

  Future<void> createNewUserButton() async {
    if (phontET.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: "Please Give your Phone Numer");
      return;
    }
    if (!_validateInput()) return;

    bool hasInternet = await AppsFunction.internetChecking();
    if (hasInternet) {
      _showErrorDialog("No Internet Connection",
          "Please check your internet settings and try again.");
      return;
    }

    try {
      loadingController.setLoading(true);

      var userProfileImageUrl = await signUpRepository.uploadUserImgeUrl(
          file: selectImageController.selectPhoto.value!);

      var user = await signUpRepository.createUserWithEmilandPasword(
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

      signUpRepository.uploadNewUserCreatingDocument(
          profileModel: profileModel, firebaseDocument: user.user!.uid);
      clearField();
      Get.offNamed(RoutesName.mainPage);
      AppsFunction.flutterToast(msg: "Sign up Successfully");
      selectImageController.selectPhoto.value = null;
    } on FirebaseAuthException catch (e) {
      AppsFunction.errorDialog(
          icon: IconAsset.warningIcon,
          title: "Exception",
          content: e.message,
          buttonText: "Okay");
    } catch (e) {
      AppsFunction.errorDialog(
          icon: IconAsset.warningIcon,
          title: "Exception",
          content: e.toString(),
          buttonText: "Okay");
    } finally {
      loadingController.setLoading(false);
    }
  }

  bool _validateInput() {
    if (passwordET.text != confirmpasswordET.text) {
      _showErrorDialog("Please Check Password",
          "Password and Confirm Password do not match.");
      return false;
    }
    if (selectImageController.selectPhoto.value == null) {
      _showErrorDialog("No Image Selected", "Please select a profile image.",
          IconAsset.noImage);
      return false;
    }
    return true;
  }

  void _showErrorDialog(String title, String content, [String? icon]) {
    AppsFunction.errorDialog(
        icon: icon ?? IconAsset.warningIcon,
        title: title,
        content: content,
        buttonText: "Okay");
  }

  clearField() {
    passwordET.clear();
    emailET.clear();
    phontET.clear();
    confirmpasswordET.clear();
    nameET.clear();
  }
}
