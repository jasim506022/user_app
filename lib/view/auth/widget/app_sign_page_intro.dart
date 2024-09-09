import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/app_colors.dart';
import '../../../res/appasset/image_asset.dart';
import '../../../res/textstyle.dart';

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
          ImagesAsset.appLogoImage,
          height: 140.h,
          width: 140.h,
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(title,
            style: Textstyle.largestText
                .copyWith(fontSize: 22.sp, color: AppColors.black)),
        SizedBox(
          height: 10.h,
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 16.sp, color: AppColors.hintLightColor),
        ),
        SizedBox(
          height: .05.sh,
        ),
      ],
    );
  }
}
