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

  static TextStyle get largeText => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 16.sp, fontWeight: FontWeight.w700);

  static TextStyle get largeBoldText => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 16.sp, fontWeight: FontWeight.bold);

  static TextStyle get largestText => GoogleFonts.roboto(
      color: theme.primaryColor, fontSize: 18.sp, fontWeight: FontWeight.bold);

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


/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gobalcolor.dart';

class Textstyle {
  BuildContext context;

  Textstyle(this.context);

  TextStyle get largeText => GoogleFonts.roboto(
      color: Theme.of(context).primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w700);

  TextStyle get largeBoldText => GoogleFonts.roboto(
      color: Theme.of(context).primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold);

  TextStyle get largestText => GoogleFonts.roboto(
      color: Theme.of(context).primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static TextStyle mediumText400lineThrough = GoogleFonts.roboto(
      decoration: TextDecoration.lineThrough,
      color: const Color(0xffcecfd2),
      fontSize: 14,
      fontWeight: FontWeight.w700);

  TextStyle get mediumText600 =>
      GoogleFonts.roboto(color:AppColors. red, fontSize: 14, fontWeight: FontWeight.w600);

  TextStyle get mediumTextbold =>
      GoogleFonts.roboto(color:AppColors. red, fontSize: 14, fontWeight: FontWeight.bold);

  TextStyle get smallText => GoogleFonts.roboto(
      color: Theme.of(context).primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w700);

  TextStyle get smallestText => GoogleFonts.roboto(
      color: Theme.of(context).primaryColor,
      fontSize: 10,
      fontWeight: FontWeight.normal);

  static TextStyle emptyTestStyle =
      GoogleFonts.roboto(color:AppColors. red, fontSize: 25, fontWeight: FontWeight.bold);
}
*/
