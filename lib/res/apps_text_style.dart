import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppsTextStyle {
  static BuildContext get context => Get.context!;

// Get the current ThemeData
  static ThemeData get theme => Theme.of(context);

  // Common TextStyle helpers

  static TextStyle _baseStyle({
    Color? color,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0.0,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return GoogleFonts.poppins(
      color: color ?? theme.primaryColor,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  // Large Normal Text
  static TextStyle get largeNormalText => GoogleFonts.poppins(
        fontSize: 16.sp,
        color: theme.primaryColor,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get labelTextStyle => GoogleFonts.poppins(
        color: theme.primaryColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle textFieldInputTextStyle([bool isEnable = false]) =>
      GoogleFonts.poppins(
        fontSize: 14.sp,
        color: isEnable ? AppColors.black : AppColors.black.withOpacity(.8),
        fontWeight: isEnable ? FontWeight.w600 : FontWeight.w800,
      );

// Ttile
  static TextStyle get titleSignPageTextStyle => GoogleFonts.roboto(
      color: theme.primaryColor,
      fontSize: 28.sp,
      fontWeight: FontWeight.w900,
      height: 1.3,
      letterSpacing: 1.2);

  // Description
  static TextStyle get descrptionTextStyle => GoogleFonts.roboto(
      color: AppColors.black.withOpacity(.7),
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      height: 1.6,
      letterSpacing: 1.2);

// Apps Logo
  static TextStyle get appsLogoTextStyole => GoogleFonts.roboto(
        color: AppColors.accentGreen,
        fontSize: 24.sp,
        fontWeight: FontWeight.w900,
      );

  // Large  Title Text Style
  static TextStyle get largeTitleTextStyleForOnBoarding => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 30.sp, fontWeight: FontWeight.w900);

// subtitle
  static TextStyle get subTitleTextStyle => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 15.sp,
        color: theme.hintColor,
      );

// App Logo Text Style
  static TextStyle get appLogoStyle => _baseStyle(
      color: AppColors.accentGreen, fontSize: 22, fontWeight: FontWeight.w900);

  // Title Text Style (App Bar) // Working
  static TextStyle get titleTextStyle =>
      _baseStyle(fontSize: 20, fontWeight: FontWeight.w800);

  // Subtitle Text Style
  static TextStyle get subtitleTextStyle => _baseStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: theme.hintColor,
      );

  // Button Text Style
  static TextStyle get buttonTextStyle => _baseStyle(
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 16);

  // Medium Bold Text
  static TextStyle get mediumBoldText =>
      _baseStyle(fontSize: 16, fontWeight: FontWeight.w700);

  // Medium Normal Text
  static TextStyle get mediumNormalText =>
      _baseStyle(fontSize: 14, fontWeight: FontWeight.w400);

// Large Bold Text
  static TextStyle get largeBoldText =>
      _baseStyle(fontSize: 16, fontWeight: FontWeight.w800);

  // Large Bold Text in Red
  static TextStyle get largeBoldRedText => _baseStyle(
      color: AppColors.red, fontSize: 18, fontWeight: FontWeight.w800);

  // Text Field Input Style
  static TextStyle textFieldInputStyle([bool isEnable = false]) => _baseStyle(
        fontSize: 14,
        color: isEnable ? AppColors.black : AppColors.black.withOpacity(.8),
        fontWeight: isEnable ? FontWeight.w600 : FontWeight.w800,
      );
  // Onboarding Title Text Style
  static TextStyle get onboardingTitleStyle => _baseStyle(
      fontSize: 30, fontWeight: FontWeight.w900, color: AppColors.black);

// Body Text Style
  static TextStyle get bodyTextStyle =>
      _baseStyle(fontWeight: FontWeight.w700, fontSize: 15);

  static TextStyle get largeText =>
      GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700);

// Larget Text
  static TextStyle get largestText =>
      _baseStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static TextStyle get largestProductText => _baseStyle(
        letterSpacing: 1.2,
        color: AppColors.red,
        fontSize: 18,
        fontWeight: FontWeight.w900,
      );

  static TextStyle get largeTitleTextStyle =>
      GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w900);

  static TextStyle get secondaryTextStyle => _baseStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get hintTextStyle => _baseStyle(
        fontSize: 14,
        color: AppColors.grey,
      );

  static TextStyle get hintBoldTextStyle => _baseStyle(
        fontSize: 14.sp,
        color: AppColors.black.withOpacity(.7),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get forgetPasswordTextStyle => _baseStyle(
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
      color: AppColors.red, fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle get rowTextbold =>
      GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold);

  static TextStyle get mediumTextbold => GoogleFonts.roboto(
      color: AppColors.red, fontSize: 14, fontWeight: FontWeight.bold);

// Small Bold Text
  static TextStyle get smallBoldText =>
      _baseStyle(fontSize: 12.sp, fontWeight: FontWeight.w700);

  static TextStyle get smallestText => _baseStyle(
        fontSize: 10,
      );

  static TextStyle emptyTestStyle = _baseStyle(
      color: AppColors.red, fontSize: 25, fontWeight: FontWeight.bold);

  static TextStyle get rattingText => _baseStyle(
        color: theme.hintColor,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      );
}

  // static TextStyle get subTitleTextStyle => _baseStyle(
  //       fontSize: 14.sp,
  //       color: theme.primaryColor,
  //       fontWeight: FontWeight.normal,
  //     );


  // static TextStyle get bodyTextStyle => _baseStyle(
  //     color: theme.primaryColor,
  //     fontWeight: FontWeight.normal,
  //     fontSize: 14.sp);

  
  // static TextStyle get titleTextStyle => GoogleFonts.roboto(
  //     color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.bold);

    // static TextStyle get largeProductFontStyle => _baseStyle(
  //     color: AppColors.red, fontSize: 18.sp, fontWeight: FontWeight.w800);