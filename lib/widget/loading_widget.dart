import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/gobalcolor.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
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
              color: black,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
