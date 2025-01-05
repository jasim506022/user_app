import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_text_style.dart';
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
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      title: Row(
        children: [
          Text(title, style: AppsTextStyle.titleTextStyle),
          AppsFunction.horizontalSpace(10),
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
          title: AppString.yes,
          onPressed: yesOnPress,
        ),
        OutlinedTextButtonWidget(
            color: AppColors.accentGreen,
            title: AppString.no,
            onPressed: noOnPress ??
                () {
                  Get.back();
                }),
      ],
    );
  }
}
