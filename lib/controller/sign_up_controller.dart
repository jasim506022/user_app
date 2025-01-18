import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/profile_model.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_function.dart';
import '../res/app_asset/app_icons.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';
import 'loading_controller.dart';
import 'select_image_controller.dart';

class SignUpController extends GetxController {
  final SignUpRepository repository;

  LoadingController loadingController = Get.find();

  SelectImageController selectImageController = Get.find();

  final TextEditingController phontET = TextEditingController();
  final TextEditingController nameET = TextEditingController();
  final TextEditingController emailET = TextEditingController();
  final TextEditingController passwordET = TextEditingController();
  final TextEditingController confirmpasswordET = TextEditingController();

  SignUpController({required this.repository});

  Future<void> createNewUserButton() async {
    if (phontET.text.trim().isEmpty) {
      AppsFunction.showToast(msg: "Please Give your Phone Numer");
      return;
    }
    if (!_validateInput()) return;

    // bool hasInternet = await AppsFunction.internetChecking();
    // if (hasInternet) {
    //   _showErrorDialog("No Internet Connection",
    //       "Please check your internet settings and try again.");
    //   return;
    // }

    try {
      loadingController.setLoading(true);

      var userProfileImageUrl = await repository.uploadUserImgeUrl(
          file: selectImageController.selectPhoto.value!);

      var user = await repository.createUserWithEmilandPasword(
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

      repository.uploadNewUserCreatingDocument(
          profileModel: profileModel, firebaseDocument: user.user!.uid);
      clearField();
      Get.offNamed(AppRoutesName.mainPage);
      AppsFunction.showToast(msg: "Sign up Successfully");
      selectImageController.selectPhoto.value = null;
    } on FirebaseAuthException catch (e) {
      // AppsFunction.errorDialog(
      //     icon: AppIcons.warningIcon,
      //     title: "Exception",
      //     content: e.message,
      //     buttonText: "Okay");
      Get.dialog(
        ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: "e.title!",
          content: e.message,
          buttonText: AppString.okay,
        ),
      );
    } catch (e) {
      Get.dialog(
        const ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: "e.title!",
          content: "e.message",
          buttonText: AppString.okay,
        ),
      );
      // AppsFunction.errorDialog(
      //     icon: AppIcons.warningIcon,
      //     title: "Exception",
      //     content: e.toString(),
      //     buttonText: "Okay");
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
          AppIcons.noImageIcon);
      return false;
    }
    return true;
  }

  void _showErrorDialog(String title, String content, [String? icon]) {
    // AppsFunction.errorDialog(
    //     icon: icon ?? AppIcons.warningIcon,
    //     title: title,
    //     content: content,
    //     buttonText: "Okay");

    Get.dialog(
      const ErrorDialogWidget(
        icon: AppIcons.warningIcon,
        title: "e.title!",
        content: "e.message",
        buttonText: AppString.okay,
      ),
    );
  }

  clearField() {
    passwordET.clear();
    emailET.clear();
    phontET.clear();
    confirmpasswordET.clear();
    nameET.clear();
  }
}
