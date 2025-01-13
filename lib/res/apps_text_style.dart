import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppsTextStyle {
  static BuildContext get context => Get.context!;

  // Utils utils = Utils(context);

  static ThemeData get theme => Theme.of(context);

  static TextStyle get appLogoFonts => GoogleFonts.roboto(
      color: AppColors.accentGreen,
      fontSize: 22.sp,
      fontWeight: FontWeight.w900);

  // App Bar TextStyle
  static TextStyle get titleTextStyle => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.w700);

// Sub Title TextStyle
  static TextStyle get subTitleTextStyle => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: theme.hintColor,
      );

  // Button TextStyle
  static TextStyle get buttonTextStyle => GoogleFonts.poppins(
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp);

  //  Medium  Text Bold
  static TextStyle get mediumBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 14.sp, fontWeight: FontWeight.w800);
// Medium Normal Textg
  static TextStyle get mediumNormalText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 14.sp, fontWeight: FontWeight.w400);

// Large Text Bold
  static TextStyle get largeBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 16.sp, fontWeight: FontWeight.w800);

  // Large Text Bold
  static TextStyle get largeBoldRedText => GoogleFonts.poppins(
      color: AppColors.red, fontSize: 18.sp, fontWeight: FontWeight.w800);

// text Field Input Text
  static TextStyle textFieldInputTextStyle([bool isEnable = false]) =>
      GoogleFonts.poppins(
        fontSize: 14.sp,
        color: isEnable ? AppColors.black : AppColors.black.withOpacity(.8),
        fontWeight: isEnable ? FontWeight.w600 : FontWeight.w800,
      );
// OnBoarding
  static TextStyle get onBoardTextStyle => GoogleFonts.inter(
      fontSize: 30.sp, fontWeight: FontWeight.w900, color: AppColors.black);

  // static TextStyle get bodyTextStyle => GoogleFonts.poppins(
  //     color: theme.primaryColor,
  //     fontWeight: FontWeight.normal,
  //     fontSize: 14.sp);

  static TextStyle get boldBodyTextStyle => GoogleFonts.poppins(
      color: theme.primaryColor, fontWeight: FontWeight.w700, fontSize: 15.sp);

  static TextStyle get largeText => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 16.sp, fontWeight: FontWeight.w700);

  // static TextStyle get largeProductFontStyle => GoogleFonts.poppins(
  //     color: AppColors.red, fontSize: 18.sp, fontWeight: FontWeight.w800);

// Larget Text
  static TextStyle get largestText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.bold);

  static TextStyle get largestProductText => GoogleFonts.poppins(
        letterSpacing: 1.2,
        color: AppColors.red,
        fontSize: 18.sp,
        fontWeight: FontWeight.w900,
      );

  // static TextStyle get titleTextStyle => GoogleFonts.roboto(
  //     color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.bold);

  static TextStyle get largeTitleTextStyle => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 22.sp, fontWeight: FontWeight.w900);

  static TextStyle get secondaryTextStyle => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w400,
      );

  // static TextStyle get subTitleTextStyle => GoogleFonts.poppins(
  //       fontSize: 14.sp,
  //       color: theme.primaryColor,
  //       fontWeight: FontWeight.normal,
  //     );

  static TextStyle get hintTextStyle => GoogleFonts.poppins(
        fontSize: 14.sp,
        color: AppColors.grey,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get hintBoldTextStyle => GoogleFonts.poppins(
        fontSize: 14.sp,
        color: AppColors.black.withOpacity(.7),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get forgetPasswordTextStyle => GoogleFonts.poppins(
        fontSize: 14.sp,
        color: AppColors.lightHintText,
        fontWeight: FontWeight.w700,
      );

  static TextStyle mediumText400lineThrough = GoogleFonts.roboto(
      decoration: TextDecoration.lineThrough,
      color: const Color(0xffcecfd2),
      fontSize: 14.sp,
      fontWeight: FontWeight.w700);

  static TextStyle get mediumText600 => GoogleFonts.roboto(
      color: AppColors.red, fontSize: 14.sp, fontWeight: FontWeight.w600);

  static TextStyle get rowTextbold => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 14.sp, fontWeight: FontWeight.bold);

  static TextStyle get mediumTextbold => GoogleFonts.roboto(
      color: AppColors.red, fontSize: 14.sp, fontWeight: FontWeight.bold);

// Small Bold Text
  static TextStyle get smallBoldText => GoogleFonts.poppins(
      color: theme.primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w700);

  static TextStyle get smallestText => GoogleFonts.roboto(
      color: theme.primaryColor,
      fontSize: 10.sp,
      fontWeight: FontWeight.normal);

  static TextStyle emptyTestStyle = GoogleFonts.roboto(
      color: AppColors.red, fontSize: 25.sp, fontWeight: FontWeight.bold);

  static TextStyle get rattingText => GoogleFonts.poppins(
        color: Theme.of(context).hintColor,
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      );
}
