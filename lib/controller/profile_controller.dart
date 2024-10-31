import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/widget/loading_widget.dart';

import '../model/app_exception.dart';
import '../model/profilemodel.dart';
import '../repository/profile_repository.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/constant/string_constant.dart';
import '../res/constants.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';
import '../widget/show_alert_dialog_widget.dart';
import 'loading_controller.dart';
import 'select_image_controller.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;

  LoadingController loadingController = Get.put(LoadingController());

  SignUpRepository signUpRepository = SignUpRepository();

  TextEditingController nameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();

  SelectImageController selectImageController = Get.find();

  var profileModel = ProfileModel().obs;
  var image = "".obs;

  var isChange = false.obs;

  ProfileController({required this.repository});

  updateCartItem({required Map<String, dynamic> map}) {
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

  Future<void> handleBackNavigaion(bool didPop) async {
    if (didPop) return;

    if (isChange.value == false) {
      Get.back();
      return;
    }
    Get.dialog(CustomAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: "Save Changed?",
        subTitle: 'do you want to save change?',
        noOnPress: () {
          isChange.value = false;
          Get.close(2);
        },
        yesOnPress: () => Get.back()));
  }

// Understand This Code
  Future<void> updateUserData() async {
    if (phoneTEC.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: "Please Give your Phone Numer");
      return;
    }

    try {
      Get.dialog(
          barrierDismissible: false,
          const LoadingWidget(message: "Profile Update"));

      if (selectImageController.selectPhoto.value != null) {
        image.value = await signUpRepository.uploadUserImgeUrl(
            file: selectImageController.selectPhoto.value!);
      }

      final updatedProfile = _buildUpdatedProfileModel();
      repository.updateUserData(map: updatedProfile.toMapProfileEdit());

      isChange.value = false;
      Get.back();
      Get.offAllNamed(RoutesName.mainPage, arguments: 3);
      AppsFunction.flutterToast(msg: "Succesfully Update");
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay",
          ),
        );
      }
    }
  }

  ProfileModel _buildUpdatedProfileModel() {
    return ProfileModel(
      address: addressTEC.text.trim(),
      phone: phoneTEC.text.trim(),
      name: nameTEC.text.trim(),
      imageurl: image.value,
    );
  }


  void addChangeListener() {
    final controllers = [
      nameTEC,
      phoneTEC,
      addressTEC,
    ];

    for (var textField in controllers) {
      textField.addListener(() {
        isChange.value = true;
      });
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await sharedPreference?.setString(
          StringConstant.imageSharedPreference, "");
      await sharedPreference?.setString(
          StringConstant.nameSharedPreference, "");
      await sharedPreference
          ?.setStringList(StringConstant.cartListSharedPreference, []);

      await repository.signOut();
      AppsFunction.flutterToast(msg: "Successfully Signed Out");
      Get.offAllNamed(RoutesName.signPage);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }


  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInformation() async {
    return await repository.getUserInformationSnapshot();
  }


  Future<void> getUserInformationSnapshot() async {
    try {
      var snapshot = await repository.getUserInformationSnapshot();
      if (snapshot.exists && snapshot.data() != null) {
        profileModel.value = ProfileModel.fromMap(snapshot.data()!);
        if (profileModel.value.status == "approved") {
          _saveProfileToSharedPreferences(profileModel.value);

          _updateTextControllers();
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


  Future<void> _saveProfileToSharedPreferences(ProfileModel profile) async {
    final prefsTasks = [
      sharedPreference!
          .setString(StringConstant.uidSharedPreference, profile.uid!),
      sharedPreference!
          .setString(StringConstant.emailSharedPreference, profile.email!),
      sharedPreference!
          .setString(StringConstant.nameSharedPreference, profile.name!),
      sharedPreference!
          .setString(StringConstant.imageSharedPreference, profile.imageurl!),
      sharedPreference!
          .setString(StringConstant.phoneSharedPreference, profile.phone!),
      sharedPreference!.setStringList(StringConstant.cartListSharedPreference,
          profile.cartlist!.map((e) => e.toString()).toList())
    ];
    await Future.wait(prefsTasks);
  }


  void _updateTextControllers() {
    nameTEC.text = profileModel.value.name ?? '';
    addressTEC.text = profileModel.value.address ?? '';
    phoneTEC.text = profileModel.value.phone ?? '';
    emailTEC.text = profileModel.value.email ?? '';
    image.value = profileModel.value.imageurl ?? '';
  }
}
