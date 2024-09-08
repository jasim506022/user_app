import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/repository/profile_repository.dart';

import '../model/app_exception.dart';
import '../model/profilemodel.dart';
import '../repository/sign_up_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/constants.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepository;

  SignUpRepository signUpRepository = SignUpRepository();

  TextEditingController nameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();

  var profileModel = ProfileModel().obs;
  var image = "".obs;
  var imageFile = Rx<File?>(null);
  var isChangeProfilePicture = false.obs;

  ProfileController(this._profileRepository);

  // getImageFromGaller() async {
  //   final ImagePicker picker = ImagePicker();
  //   imageFile.value = await picker.pickImage(source: ImageSource.gallery);
  //   isChangeProfilePicture.value = true;
  // }

   void selectImage({required ImageSource imageSource}) async {
    try {
       imageFile.value =
          await signUpRepository.captureImageSingle(imageSource: imageSource);
      
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

  @override
  void onInit() {
    // imageFile.value = null;
    super.onInit();
  }

  getUserInformationSnapshot() async {
    var snapshot = await _profileRepository.getUserInformationSnapshot();

    if (snapshot.exists) {
      profileModel.value = ProfileModel.fromMap(snapshot.data()!);
      if (profileModel.value.status == "approved") {
        sharedPreference = await SharedPreferences.getInstance();
        await sharedPreference!.setString("uid", profileModel.value.uid!);
        await sharedPreference!.setString("email", profileModel.value.email!);
        await sharedPreference!.setString("name", profileModel.value.name!);
        await sharedPreference!
            .setString("imageurl", profileModel.value.imageurl!);
        await sharedPreference!.setString("phone", profileModel.value.phone!);
        List<String> list =
            profileModel.value.cartlist!.map((e) => e.toString()).toList();
        await sharedPreference!.setStringList("cartlist", list);

        nameTEC.text = profileModel.value.name!;
        addressTEC.text = profileModel.value.address!;
        phoneTEC.text = profileModel.value.phone!;
        emailTEC.text = profileModel.value.email!;
        image.value = profileModel.value.imageurl!;
      } else {
        AppsFunction.flutterToast(msg: "User Doesn't Exist");
      }
    }
  }
}
