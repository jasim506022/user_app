import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import 'outlined_text_button_widget.dart';

/*
/// A reusable alert dialog widget with customizable title, content, buttons, and icon.
class ShowAlertDialogWidget extends StatelessWidget {
  const ShowAlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onYesPressed,
    this.onNoPressed,
    required this.icon,
    this.yesButtonColor,
    this.noButtonColor,
  });

  final String title;
  final String content;
  final VoidCallback onYesPressed;
  final VoidCallback? onNoPressed;
  final IconData icon;
  final Color? yesButtonColor;
  final Color? noButtonColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitleRow(),
      content: Text(content),
      actions: _buildActions(),
    );
  }

  /// Builds the title with an icon next to it
  Row _buildTitleRow() {
    return Row(
      children: [
        Text(title),
        AppsFunction.horizontalSpacing(10),
        Container(
          padding: EdgeInsets.all(5.r),
          decoration:
              BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  /// Builds the action buttons (Yes & No)
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

*/
// Modify
/// A customizable alert dialog widget with a title, content, and action buttons.
class ShowAlertDialogWidget extends StatelessWidget {
  const ShowAlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirmPressed,
    this.onCancelPressed,
    required this.icon,
    this.iconColor,
    this.confirmButtonColor,
    this.cancelButtonColor,
  });

  final String title;
  final String content;
  final VoidCallback onConfirmPressed;
  final VoidCallback? onCancelPressed;
  final IconData icon;
  final Color? iconColor;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildDialogHeader(),
      content: Text(content),
      actions: _buildActionButtons(),
    );
  }

  /// Builds the alert dialog header with an icon and title.
  Row _buildDialogHeader() {
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

  /// Builds the action buttons for the dialog.
  List<Widget> _buildActionButtons() {
    return [
      OutlinedTextButtonWidget(
        color: confirmButtonColor ?? AppColors.accentGreen,
        title: AppString.btnYes,
        onPressed: onConfirmPressed,
      ),
      OutlinedTextButtonWidget(
        color: cancelButtonColor ?? AppColors.red,
        title: AppString.btnNo,
        onPressed: onCancelPressed ?? () => Get.back(),
      ),
    ];
  }
}
