import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/Textstyle.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.text,
    required this.function,
  });

  final String text;

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text(
          text,
          style: Textstyle.largestText,
        ),
        const Spacer(),
        InkWell(
          onTap: function,
          child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.greenColor,
          ),
        )
      ],
    );
  }
}
