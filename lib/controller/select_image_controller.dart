import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/model/app_exception.dart';
import 'package:user_app/repository/select_image_repository.dart';

import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';

class SelectImageController extends GetxController {
  final SelectImageRepository selectImageRepository;

  SelectImageController({required this.selectImageRepository});
  var selectPhoto = Rx<File?>(null);

  // String uploadImage = "";

  void selectImage({required ImageSource imageSource}) async {
    try {
      var image = await selectImageRepository.captureImageSingle(
          imageSource: imageSource);
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
}
