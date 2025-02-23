import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/res/apps_text_style.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/network_utili.dart';

/*
class IconWithButtonWidget extends StatelessWidget {
  const IconWithButtonWidget({
    super.key,
    required this.function,
    required this.color,
    required this.image,
    required this.title,
  });
  final Function function;
  final Color color;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        height: 0.071.sh,
        width: 1.sw,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.r)),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: .04.sh,
                width: .04.sh,
                color: AppColors.white,
              ),
              SizedBox(
                width: 10.h,
              ),
              Text(
                title,
                style: AppsTextStyle.buttonTextStyle
                    ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

/*
class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    required this.tap,
    required this.color,
    required this.image,
    required this.title,
  });

  final VoidCallback tap;
  final Color color;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 34.h,
              width: 34.h,
              color: AppColors.white,
            ),
            AppsFunction.horizontalSpacing(10),
            Text(
              title,
              style: AppsTextStyle.buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

*/

/// A reusable social login button with an icon, label, and customizable background color.
///
/// This button is designed for social authentication (e.g., Google, Facebook).
/// It consists of an icon and a text label, both centered inside a rounded container.
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.iconPath,
    required this.label,
  });

  final VoidCallback onTap;
  final Color color;
  final String iconPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async =>
          await NetworkUtils.executeWithInternetCheck(action: onTap),
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 34.h,
              width: 34.h,
              color: AppColors.white,
            ),
            AppsFunction.horizontalSpacing(10),
            Text(
              label,
              style: AppsTextStyle.buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
