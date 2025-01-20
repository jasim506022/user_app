import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import 'outlined_text_button_widget.dart';

class ShowAlertDialogWidget extends StatelessWidget {
  const ShowAlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onYesPressed,
    this.onNoPressed,
    required this.icon,
    this.iconColor,
    this.yesButtonColor,
    this.noButtonColor,
  });

  final String title;
  final String content;
  final VoidCallback onYesPressed;
  final VoidCallback? onNoPressed;
  final IconData icon;
  final Color? iconColor;
  final Color? yesButtonColor;
  final Color? noButtonColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitleRow(),
      content: Text(
        content,
      ),
      actions: _buildActions(),
    );
  }

  Row _buildTitleRow() {
    return Row(
      children: [
        Text(title),
        AppsFunction.horizontalSpacing(10),
        Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
              color: iconColor ?? AppColors.red, shape: BoxShape.circle),
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions() {
    return [
      OutlinedTextButtonWidget(
        color: yesButtonColor ?? AppColors.red,
        title: AppString.yes,
        onPressed: onYesPressed,
      ),
      OutlinedTextButtonWidget(
        color: noButtonColor ?? AppColors.accentGreen,
        title: AppString.no,
        onPressed: onNoPressed ?? () => Get.back(),
      ),
    ];
  }
}
