import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/apps_text_style.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: AppsTextStyle.titleTextStyle,
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.accentGreen,
          ),
        )
      ],
    );
  }
}
