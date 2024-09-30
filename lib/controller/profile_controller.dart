import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/repository/profile_repository.dart';
import 'package:user_app/repository/sign_up_repository.dart';
import 'package:user_app/res/routes/routesname.dart';

import '../model/app_exception.dart';
import '../model/profilemodel.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/constant/string_constant.dart';
import '../res/constants.dart';
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

  Future<void> updateUserData({Map<String, dynamic>? map}) async {
    if (phoneTEC.text.trim().isEmpty) {
      AppsFunction.flutterToast(msg: "Please Give your Phone Numer");
      return;
    }
    bool hasInternet = await AppsFunction.internetChecking();
    if (hasInternet) {
      _showErrorDialog("No Internet Connection",
          "Please check your internet settings and try again.");
      return;
    }
    try {
      loadingController.setLoading(true);
      if (selectImageController.selectPhoto.value != null) {
        image.value = await signUpRepository.uploadUserImgeUrl(
            file: selectImageController.selectPhoto.value!);
      }

      ProfileModel model = ProfileModel();
      model.address = addressTEC.text.trim();
      model.phone = phoneTEC.text.trim();
      model.name = nameTEC.text.trim();
      model.imageurl = image.value;

      repository.updateUserData(map: map ?? model.toMapProfileEdit());
      isChange.value = false;
      loadingController.setLoading(false);
      Get.offAllNamed(RoutesName.mainPage, arguments: 3);
      AppsFunction.flutterToast(msg: "Succesfully Update");
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

  Future<void> signOut() async {
    await sharedPreference?.setString(StringConstant.imageSharedPreference, "");
    await sharedPreference?.setString(StringConstant.nameSharedPreference, "");
    repository.signOut();
    AppsFunction.flutterToast(msg: "Successfully Signout ");
    Get.offAllNamed(RoutesName.signPage);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await repository.getUserInformationSnapshot();
  }

  void _showErrorDialog(String title, String content, [String? icon]) {
    AppsFunction.errorDialog(
        icon: icon ?? IconAsset.warningIcon,
        title: title,
        content: content,
        buttonText: "Okay");
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
