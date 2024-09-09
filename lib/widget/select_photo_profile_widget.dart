import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/app_colors.dart';
import '../controller/select_image_controller.dart';
import '../res/textstyle.dart';

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
          SizedBox(height: 10.h),
          Align(
              alignment: Alignment.center,
              child: Text("Select Photo", style: Textstyle.largeBoldText)),
          SizedBox(
            height: 10.h,
          ),
          _selectPhotoOption()
        ],
      ),
    );
  }

  Row _selectPhotoOption() {
    SelectImageController signUpController = Get.find();
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
                  border: Border.all(color: AppColors.greenColor)),
              child: Icon(
                icon,
                color: AppColors.greenColor,
              ),
            ),
            SizedBox(
              height: 5.w,
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
