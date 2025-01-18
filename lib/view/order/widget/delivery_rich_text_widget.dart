import 'package:flutter/material.dart';
import 'package:user_app/res/app_function.dart';

import '../../../res/apps_text_style.dart';

class DeliveryRichTextWidget extends StatelessWidget {
  const DeliveryRichTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.color,
  });

  final String title;
  final String subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: AppsTextStyle.mediumBoldText,
          ),
          WidgetSpan(child: AppsFunction.horizontalSpacing(10)),
          TextSpan(
              text: subTitle,
              style: AppsTextStyle.mediumNormalText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color ?? Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}
