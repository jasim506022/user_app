import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/res/app_colors.dart';

class CustomTextButtonWidget extends StatelessWidget {
  const CustomTextButtonWidget(
      {super.key,
      required this.onPressed,
      required this.colorBorder,
      required this.title,
      this.textColor});

  final VoidCallback onPressed;
  final Color colorBorder;
  final String title;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            side: BorderSide(
              color: colorBorder,
              width: 2,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: onPressed,
        child: Text(title,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: textColor ?? AppColors.black)));
  }
}
