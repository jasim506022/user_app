import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/res/apps_text_style.dart';

import '../res/app_colors.dart';
import 'dialog_text_button_widget.dart';

class ShowAlertDialogWidget extends StatelessWidget {
  const ShowAlertDialogWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.yesOnPress,
    required this.noOnPress,
  });

  final String title;
  final String subTitle;
  final VoidCallback yesOnPress;
  final VoidCallback noOnPress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Row(
        children: [
          Text(title, style: AppsTextStyle.titleTextStyle),
          SizedBox(
            width: 5.w,
          ),
          Container(
              padding: EdgeInsets.all(5.r),
              decoration:
                  BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
              child: Icon(
                Icons.question_mark_rounded,
                color: AppColors.white,
              )),
        ],
      ),
      content: Text(subTitle, style: AppsTextStyle.subTitleTextStyle),
      actions: [
        DialogTextButtonWidget(
          textColor: AppColors.red,
          colorBorder: AppColors.red,
          title: "Yes",
          onPressed: yesOnPress,
        ),
        DialogTextButtonWidget(
            colorBorder: AppColors.greenColor,
            title: "No",
            onPressed: noOnPress),
      ],
    );
  }
}
