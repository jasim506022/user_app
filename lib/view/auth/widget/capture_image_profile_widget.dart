import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../res/app_colors.dart';
import '../../../widget/select_photo_profile_widget.dart';

/*
class CaptureImageProfileWidget extends StatelessWidget {
  const CaptureImageProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.find();
    return InkWell(
      onTap: () async {
        if (!(await NetworkUtili.verifyInternetStatus())) {
          Get.bottomSheet(
              backgroundColor: AppColors.white, const SelectPhotoProfile());
        }
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey, width: 3.w)),
        child: Obx(() {
          var imageFile =
              signUpController.selectImageController.selectPhoto.value;
          return CircleAvatar(
            radius: 0.2.sw,
            backgroundImage: imageFile == null ? null : FileImage(imageFile),
            backgroundColor: AppColors.lightBackground,
            foregroundColor: AppColors.black,
            child: imageFile == null
                ? Icon(
                    Icons.add_photo_alternate,
                    size: 0.2.sw,
                    color: AppColors.grey,
                  )
                : null,
          );
        }),
      ),
    );
  }
}

*/

class ProfileImagePickerWidget extends StatelessWidget {
  const ProfileImagePickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return InkWell(
      onTap: () => Get.bottomSheet(
          backgroundColor: AppColors.white,
          const ProfilePhotoOptionSheetWidget()),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.red, width: 3.w)),
        child: Obx(() {
          var selectedPhoto =
              authController.selectImageController.selectPhoto.value;
          return CircleAvatar(
            radius: 0.2.sw,
            backgroundImage:
                selectedPhoto != null ? FileImage(selectedPhoto) : null,
            backgroundColor: AppColors.lightBackground,
            child: selectedPhoto == null
                ? Icon(
                    Icons.add_photo_alternate,
                    size: 0.2.sw,
                    color: AppColors.grey,
                  )
                : const SizedBox.shrink(),
          );
        }),
      ),
    );
  }
}
