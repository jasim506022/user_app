import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:user_app/res/apps_text_style.dart';

import '../res/app_colors.dart';
import '../res/network_utili.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.simpleText,
    required this.colorText,
    required this.function,
  });

  final String simpleText;
  final String colorText;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: simpleText,
        style: AppsTextStyle.mediumBoldText,
      ),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              await NetworkUtili.internetCheckingWFunction(
                  function: () => function());
            },
          text: colorText,
          style: AppsTextStyle.buttonTextStyle.copyWith(
              decoration: TextDecoration.underline,
              color: AppColors.accentGreen))
    ]));
  }
}
