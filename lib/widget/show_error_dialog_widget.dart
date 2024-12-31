import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/res/app_string.dart';

import '../res/app_colors.dart';

class ShowErrorDialogWidget extends StatelessWidget {
  const ShowErrorDialogWidget({
    super.key,
    required this.title,
    required this.message,
  });

  final String title, message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Row(
        children: [
          Flexible(
            child: Text(
              "$title Error",
              style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            width: Get.width * .033,
          ),
          Icon(
            Icons.error_sharp,
            color: AppColors.red,
          )
        ],
      ),
      content: Text(
        message,
        style: GoogleFonts.poppins(
            color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 14),
      ),
      actions: [
        TextButton(
            onPressed: () {
              // Navigator.pop(context);
              Get.back();
            },
            child: Text(
              AppString.okay,
              style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ))
      ],
    );
  }
}
