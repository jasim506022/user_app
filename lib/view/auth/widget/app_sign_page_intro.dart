import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_asset/app_imges.dart';
import '../../../res/apps_text_style.dart';

class AppSignInPageIntro extends StatelessWidget {
  const AppSignInPageIntro({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
        ),
        Image.asset(
          AppImages.appLogo,
          height: 140.h,
          width: 140.h,
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(title, style: AppsTextStyle.largeTitleTextStyle),
        SizedBox(
          height: 10.h,
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: AppsTextStyle.secondaryTextStyle,
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
