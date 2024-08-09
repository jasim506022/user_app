import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/app_colors.dart';
import '../../../res/appasset/image_asset.dart';
import '../../../res/textstyle.dart';

class AppSignInPageIntro extends StatelessWidget {
  const AppSignInPageIntro({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        SizedBox(
          height: Get.height * .071,
        ),
        Image.asset(
          ImagesAsset.appLogoImage,
          height: Get.height * .177,
          width: Get.height * .177,
        ),
        SizedBox(
          height: Get.height * .012,
        ),
        Text(title,
            style: Textstyle.largestText
                .copyWith(fontSize: 24, color: AppColors.black)),
        SizedBox(
          height: Get.height * .012,
        ),
        Text(
          "Check our fresh viggies from Jasim Grocery",
          style: GoogleFonts.poppins(
              fontSize: 16, color: AppColors.hintLightColor),
        ),
        SizedBox(
          height: Get.height * .059,
        ),
      ],
    );
  }
}
