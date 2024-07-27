import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/res/constants.dart';

import '../../res/app_colors.dart';
import '../../res/textstyle.dart';

class AppSignInPageIntro extends StatelessWidget {
  const AppSignInPageIntro({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    // Textstyle txtStyle = Textstyle(context);
    return Column(
      children: [
        SizedBox(
          height: mq.height * .071,
        ),
        Image.asset(
          "asset/image/logo.png",
          height: mq.height * .177,
          width: mq.height * .177,
        ),
        SizedBox(
          height: mq.height * .012,
        ),
        Text(title,
            style: Textstyle.largestText
                .copyWith(fontSize: 24, color: AppColors.black)),
        SizedBox(
          height: mq.height * .012,
        ),
        Text(
          "Check our fresh viggies from Jasim Grocery",
          style: GoogleFonts.poppins(
              fontSize: 16, color: AppColors.hintLightColor),
        ),
        SizedBox(
          height: mq.height * .059,
        ),
      ],
    );
  }
}
