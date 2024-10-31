import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/apps_text_style.dart';
import 'round_button_widget.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String? content;
  final String? buttonText;
  final bool barrierDismissible;

  const ErrorDialogWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.content,
    this.buttonText,
    this.barrierDismissible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              height: 100.h,
              width: 100.w,
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: AppsTextStyle.titleTextStyle.copyWith(
                color: AppColors.deepGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15.h),
            if (content != null)
              Text(
                content!,
                textAlign: TextAlign.center,
                style: AppsTextStyle.subTitleTextStyle,
              ),
            SizedBox(height: 20.h),
            if (buttonText != null)
              RoundButtonWidget(
                buttonColors: AppColors.red,
                width: double.infinity,
                title: buttonText!,
                onPress: () => Get.back(),
              ),
          ],
        ),
      ),
    );
  }
}
