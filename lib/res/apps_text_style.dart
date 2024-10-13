import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppsTextStyle {
  static BuildContext get context => Get.context!;

  static ThemeData get theme => Theme.of(context);

  static TextStyle get appLogoFonts => GoogleFonts.roboto(
      color: AppColors.greenColor,
      fontSize: 22.sp,
      fontWeight: FontWeight.w900);

  static TextStyle get onBoardTextStyle => GoogleFonts.inter(
      fontSize: 30.sp, fontWeight: FontWeight.w900, color: AppColors.black);

  static TextStyle get buttonTextStyle => GoogleFonts.poppins(
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp);

  static TextStyle get bodyTextStyle => GoogleFonts.poppins(
      color: theme.primaryColor,
      fontWeight: FontWeight.normal,
      fontSize: 15.sp);

  static TextStyle get boldBodyTextStyle => GoogleFonts.poppins(
      color: theme.primaryColor, fontWeight: FontWeight.w700, fontSize: 15.sp);

  static TextStyle get largeText => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 16.sp, fontWeight: FontWeight.w700);

  static TextStyle get largeBoldText => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 16.sp, fontWeight: FontWeight.bold);

  static TextStyle get largestText => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.bold);

  static TextStyle get titleTextStyle => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.bold);

  static TextStyle get largeTitleTextStyle => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 22.sp, fontWeight: FontWeight.w900);

  static TextStyle get secondaryTextStyle => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get subTitleTextStyle => GoogleFonts.poppins(
        fontSize: 14.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get textFieldInputTextStyle => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get hintTextStyle => GoogleFonts.poppins(
        fontSize: 14.sp,
        color: AppColors.grey,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get forgetPasswordTextStyle => GoogleFonts.poppins(
        fontSize: 14.sp,
        color: AppColors.hintLightColor,
        fontWeight: FontWeight.w700,
      );

  static TextStyle mediumText400lineThrough = GoogleFonts.roboto(
      decoration: TextDecoration.lineThrough,
      color: const Color(0xffcecfd2),
      fontSize: 14.sp,
      fontWeight: FontWeight.w700);

  static TextStyle get mediumText600 => GoogleFonts.roboto(
      color: AppColors.red, fontSize: 14.sp, fontWeight: FontWeight.w600);

  static TextStyle get mediumTextbold => GoogleFonts.roboto(
      color: AppColors.red, fontSize: 14.sp, fontWeight: FontWeight.bold);

  static TextStyle get smallText => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w700);

  static TextStyle get smallestText => GoogleFonts.roboto(
      color: theme.primaryColor,
      fontSize: 10.sp,
      fontWeight: FontWeight.normal);

  static TextStyle emptyTestStyle = GoogleFonts.roboto(
      color: AppColors.red, fontSize: 25.sp, fontWeight: FontWeight.bold);
}
