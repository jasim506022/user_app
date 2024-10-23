import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/apps_text_style.dart';

import '../res/app_colors.dart';
import 'outlined_text_button_widget.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  const CustomAlertDialogWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.yesOnPress,
    this.noOnPress,
    required this.icon,
  });

  final String title;
  final String subTitle;
  final VoidCallback yesOnPress;
  final VoidCallback? noOnPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Row(
        children: [
          Text(title, style: AppsTextStyle.titleTextStyle),
          SizedBox(
            width: 10.w,
          ),
          Container(
              padding: EdgeInsets.all(3.r),
              decoration:
                  BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
              child: Icon(
                icon,
                color: AppColors.white,
                size: 20.h,
              )),
        ],
      ),
      content: Text(subTitle,
          style: AppsTextStyle.subTitleTextStyle
              .copyWith(color: Theme.of(context).primaryColor)),
      actions: [
        OutlinedTextButtonWidget(
          color: AppColors.red,
          title: "Yes",
          onPressed: yesOnPress,
        ),
        OutlinedTextButtonWidget(
            color: AppColors.greenColor,
            title: "No",
            onPressed: noOnPress ??
                () {
                  Get.back();
                }),
      ],
    );
  }
}
