import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/controller/signup_controller.dart';

import '../res/constants.dart';
import '../../res/app_colors.dart';
import '../res/textstyle.dart';

class SelectPhotoProfile extends StatelessWidget {
  const SelectPhotoProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController(
      Get.find(),
    ));
    // Textstyle textstyle = Textstyle(context);
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
              width: mq.width * .22,
              height: mq.height * .005,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          SizedBox(height: mq.height * .02),
          Align(
              alignment: Alignment.center,
              child: Text("Select Photo", style: Textstyle.largeBoldText)),
          SizedBox(
            height: mq.height * .01,
          ),
          _selectPhotoOption(signUpController)
        ],
      ),
    );
  }

  Row _selectPhotoOption(
      SignUpController signUpController) {
    return Row(
      children: [
        _buildPhotoOption("Camera", Icons.camera_alt, () {
          Get.back();

          signUpController.selectImage(imageSource: ImageSource.camera);
        }),
        SizedBox(
          width: mq.width * .066,
        ),
        _buildPhotoOption("Gallery", Icons.photo_album, () {
          Get.back();

          signUpController.selectImage(imageSource: ImageSource.gallery);
        }),
      ],
    );
  }

  Padding _buildPhotoOption(
       String title, IconData icon, VoidCallback funcion) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mq.width * .012, vertical: mq.height * .012),
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
              height: mq.width * .01,
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
