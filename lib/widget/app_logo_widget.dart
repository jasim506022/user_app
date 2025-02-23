import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_asset/app_icons.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';
import '../res/apps_text_style.dart';

/// A reusable widget that displays the application logo and name.
/// Ensures proper scaling and spacing using `flutter_screenutil`
class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppIcons.appIcon,
          height: 80.h,
          width: 100.w,
          fit: BoxFit.fill,
        ),
        AppsFunction.verticalSpacing(10),
        Text(AppString.appName, style: AppsTextStyle.appsLogoTextStyle),
      ],
    );
  }
}
