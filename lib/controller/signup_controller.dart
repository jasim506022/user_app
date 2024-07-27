import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/model/app_exception.dart';
import 'package:user_app/model/profilemodel.dart';
import 'package:user_app/repository/signup_repository.dart';

import '../res/app_function.dart';
import '../res/constants.dart';
import '../res/routes/routesname.dart';
import 'loading_controller.dart';

class SignUpController extends GetxController {
  final SignUpRepository _signUpRepository;

  LoadingController loadingController = Get.put(LoadingController());

  SignUpController(this._signUpRepository);

  var selectPhoto = Rx<File?>(null);

  void selectImage({required ImageSource imageSource}) async {
    var image =
        await _signUpRepository.captureImageSingle(imageSource: imageSource);

    selectPhoto.value = image;
  }

  Future<void> createNewUser(
      {required String email,
      required String name,
      required String phone,
      required String password}) async {
    try {
      loadingController.setLoading(true);
      var userProfileImageUrl =
          await _signUpRepository.uploadUserImgeUrl(file: selectPhoto.value!);

      var user = await _signUpRepository.createUserWithEmilandPasword(
          email: email, password: password);

      ProfileModel profileModel = ProfileModel(
        address: "",
        cartlist: ["initial"],
        email: email,
        name: name,
        imageurl: userProfileImageUrl,
        phone: phone,
        status: "approved",
        uid: user.user!.uid,
      );

      _signUpRepository.uploadNewUserCreatingDocument(
          profileModel: profileModel, firebaseDocument: user.user!.uid);
      Get.offNamed(RoutesName.signPage);
      globalMethod.flutterToast(msg: "Sign in Successfully");
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
