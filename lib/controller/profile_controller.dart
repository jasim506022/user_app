import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';
import 'package:user_app/widget/loading_widget.dart';

import '../model/app_exception.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_constant.dart';
import '../res/app_function.dart';
import '../res/app_asset/app_icons.dart';
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

  Future<void> handleBackNavigaion(bool didPop) async {
    if (didPop) return;

    if (!isChange.value) {
      Get.back();
      return;
    }
    Get.dialog(CustomAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: AppString.saveChanged,
        subTitle: AppString.doYouWantSave,
        noOnPress: () {
          isChange(false);
          Get.close(2);
        },
        yesOnPress: () => Get.back()));
  }

  Future<void> updateUserCartData({required Map<String, dynamic> map}) async {
    try {
      await repository.updateUserData(map: map);
    } catch (e) {
      _handleError(e);
    }
  }

// Understand This Code
  Future<void> updateUserData() async {
    if (phoneTEC.text.trim().isEmpty) {
      AppsFunction.showToast(msg: AppString.pleaseGiveYourPhoenNumber);
      return;
    }

    try {
      Get.dialog(
          barrierDismissible: false,
          const LoadingWidget(message: AppString.profileUdate));

      if (selectImageController.selectPhoto.value != null) {
        image.value = await signUpRepository.uploadUserImgeUrl(
            file: selectImageController.selectPhoto.value!);
      }

      final updatedProfile = _buildUpdatedProfileModel();
      repository.updateUserData(map: updatedProfile.toMapProfileEdit());
      isChange(false);
      Get.back();
      Get.offAllNamed(AppRoutesName.mainPage, arguments: 3);
      AppsFunction.showToast(msg: AppString.successfullyUpdate);
    } catch (e) {
      Get.back();
      _handleError(e);
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
      await AppConstant.sharedPreference
          ?.setString(AppString.imageSharedPreference, "");
      await AppConstant.sharedPreference
          ?.setString(AppString.nameSharedPreference, "");
      await AppConstant.sharedPreference
          ?.setStringList(AppString.cartListSharedPreference, []);

      await repository.signOut();
      AppsFunction.showToast(msg: AppString.successfullySignedOut);
      Get.offAllNamed(AppRoutesName.signInPage);
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
        if (profileModel.value.status == AppString.approved) {
          _saveProfileToSharedPreferences(profileModel.value);

          _updateTextControllers();
        } else {
          AppsFunction.showToast(msg: AppString.userIsDisable);
        }
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _saveProfileToSharedPreferences(ProfileModel profile) async {
    final prefsTasks = [
      AppConstant.sharedPreference!
          .setString(AppString.uidSharedPreference, profile.uid!),
      AppConstant.sharedPreference!
          .setString(AppString.emailSharedPreference, profile.email!),
      AppConstant.sharedPreference!
          .setString(AppString.nameSharedPreference, profile.name!),
      AppConstant.sharedPreference!
          .setString(AppString.imageSharedPreference, profile.imageurl!),
      AppConstant.sharedPreference!
          .setString(AppString.phoneSharedPreference, profile.phone!),
      AppConstant.sharedPreference!.setStringList(
          AppString.cartListSharedPreference,
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

  void _handleError(dynamic error) {
    if (error is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: error.title!,
          content: error.message,
          buttonText: AppString.okay,
        ),
      );
    }
  }
}
