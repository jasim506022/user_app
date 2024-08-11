import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/controller/sign_up_controller.dart';

import '../../res/app_colors.dart';
import '../res/textstyle.dart';

class SelectPhotoProfile extends StatelessWidget {
  const SelectPhotoProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Get.width * .22,
              height: Get.height * .005,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          SizedBox(height: Get.height * .02),
          Align(
              alignment: Alignment.center,
              child: Text("Select Photo", style: Textstyle.largeBoldText)),
          SizedBox(
            height: Get.height * .01,
          ),
          _selectPhotoOption()
        ],
      ),
    );
  }

  Row _selectPhotoOption() {
    SignUpController signUpController = Get.find();
    return Row(
      children: [
        _buildTakePhotoOption("Camera", Icons.camera_alt, () {
          Get.back();

          signUpController.selectImage(imageSource: ImageSource.camera);
        }),
        SizedBox(
          width: Get.width * .066,
        ),
        _buildTakePhotoOption("Gallery", Icons.photo_album, () {
          Get.back();

          signUpController.selectImage(imageSource: ImageSource.gallery);
        }),
      ],
    );
  }

  Padding _buildTakePhotoOption(
      String title, IconData icon, VoidCallback funcion) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * .012, vertical: Get.height * .012),
      child: InkWell(
        onTap: funcion,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.greenColor)),
              child: Icon(
                icon,
                color: AppColors.greenColor,
              ),
            ),
            SizedBox(
              height: Get.width * .01,
            ),
            Text(
              title,
              style:
                  Textstyle.mediumText600.copyWith(color: AppColors.greenColor),
            ),
          ],
        ),
      ),
    );
  }
}
