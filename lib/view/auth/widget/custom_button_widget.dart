import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/loading_controller.dart';
import '../../../res/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key, required this.onPressed, required this.title});

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.022, vertical: Get.height * 0.018),
        ),
        onPressed: onPressed,
        child: Obx(
          () => loadingController.loading.value
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.white,
                  ),
                )
              : Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
        ));
  }
}
