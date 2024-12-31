import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/res/app_function.dart';

import '../../res/app_colors.dart';
import '../controller/select_image_controller.dart';
import '../res/app_string.dart';
import '../res/apps_text_style.dart';

class SelectPhotoProfile extends StatelessWidget {
  const SelectPhotoProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: .2.sw,
              height: 3.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.circular(2.r)),
            ),
          ),
          AppsFunction.verticleSpace(10),
          Align(
              alignment: Alignment.center,
              child: Text("Select Photo", style: AppsTextStyle.titleTextStyle)),
          AppsFunction.verticleSpace(10),
          _selectPhotoOption()
        ],
      ),
    );
  }

  Row _selectPhotoOption() {
    SelectImageController signUpController = Get.find();
    return Row(
      children: [
        _buildTakePhotoOption(AppString.camera, Icons.camera_alt, () {
          Get.back();

          signUpController.selectImage(imageSource: ImageSource.camera);
        }),
        AppsFunction.horizontalSpace(20),
        _buildTakePhotoOption(AppString.gallery, Icons.photo_album, () {
          Get.back();

          signUpController.selectImage(imageSource: ImageSource.gallery);
        }),
      ],
    );
  }

  Padding _buildTakePhotoOption(
      String title, IconData icon, VoidCallback funcion) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
      child: InkWell(
        onTap: funcion,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accentGreen)),
              child: Icon(
                icon,
                color: AppColors.accentGreen,
              ),
            ),
            AppsFunction.verticleSpace(5),
            Text(
              title,
              style: AppsTextStyle.boldBodyTextStyle
                  .copyWith(color: AppColors.accentGreen),
            ),
          ],
        ),
      ),
    );
  }
}
