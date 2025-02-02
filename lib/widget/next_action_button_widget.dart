import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_colors.dart';
import '../res/app_function.dart';
import '../res/apps_text_style.dart';

/// A reusable button widget with a customizable title and an arrow icon.
/// Commonly used for navigation actions like 'Next' or 'Get Started'.
class NextActionButtonWidget extends StatelessWidget {
  const NextActionButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  /// Callback triggered when the button is tapped.
  final VoidCallback onTap;

  /// The label displayed on the button.
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        decoration: BoxDecoration(
            color: AppColors.black, borderRadius: BorderRadius.circular(15.r)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: AppsTextStyle.buttonTextStyle),
            AppsFunction.horizontalSpacing(10),
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
