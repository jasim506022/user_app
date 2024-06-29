import 'package:flutter/material.dart';

import '../res/textstyle.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          height: 600,
          width: 300,
        ),
        Positioned(
          top: 120,
          left: 130,
          right: 40,
          child: Center(
            child: Container(
              height: 300,
              width: 130,
              alignment: Alignment.center,
              child: Text(title, style: Textstyle.emptyTestStyle),
            ),
          ),
        )
      ],
    );
  }
}
