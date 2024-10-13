import 'package:flutter/material.dart';
import 'package:user_app/res/app_colors.dart';
import 'package:user_app/res/apps_text_style.dart';

class DialogTextButtonWidget extends StatelessWidget {
  const DialogTextButtonWidget(
      {super.key,
      required this.onPressed,
      required this.colorBorder,
      required this.title,
      this.textColor});

  final VoidCallback onPressed;
  final Color colorBorder;
  final String title;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            side: BorderSide(
              color: colorBorder,
              width: 2,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: onPressed,
        child: Text(title,
            style: AppsTextStyle.buttonTextStyle
                .copyWith(color: textColor ?? AppColors.black)));
  }
}
