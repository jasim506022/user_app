import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_colors.dart';
import '../res/apps_text_style.dart';

class CustomRoundActionButton extends StatelessWidget {
  const CustomRoundActionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.horizontal,
  });
  final String title;
  final VoidCallback onTap;
  final double? horizontal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.accentGreen),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: horizontal ?? 40.w, vertical: 12.h)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: AppsTextStyle.buttonTextStyle,
        ));
  }
}
