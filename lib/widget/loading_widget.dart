import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:AppColors. white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),
          Text(
            "$message \n Pleasing Waiting........",
            style: GoogleFonts.poppins(
              color:AppColors. black,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
