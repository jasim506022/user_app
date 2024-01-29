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
      GoogleFonts.roboto(color: red, fontSize: 14, fontWeight: FontWeight.w600);

  TextStyle get mediumTextbold =>
      GoogleFonts.roboto(color: red, fontSize: 14, fontWeight: FontWeight.bold);

  TextStyle get smallText => GoogleFonts.roboto(
      color: Theme.of(context).primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w700);

  TextStyle get smallestText => GoogleFonts.roboto(
      color: Theme.of(context).primaryColor,
      fontSize: 10,
      fontWeight: FontWeight.normal);

  static TextStyle emptyTestStyle =
      GoogleFonts.roboto(color: red, fontSize: 25, fontWeight: FontWeight.bold);
}
