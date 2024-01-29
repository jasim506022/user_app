import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/const/gobalcolor.dart';

class CartBadge extends StatelessWidget {
  final int itemCount;
  final IconData icon;

  const CartBadge(
      {super.key,
      required this.itemCount,
      required this.icon,
      required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            icon: Icon(
              icon,
              color: color,
            ),
            onPressed: () {}),
        if (itemCount > 0)
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: red,
                borderRadius: BorderRadius.circular(15),
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
                itemCount.toString(),
                style: GoogleFonts.roboto(
                    color: white, // Text color for the badge
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
