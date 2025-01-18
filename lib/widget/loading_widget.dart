import 'package:flutter/material.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/app_string.dart';
import 'package:user_app/res/apps_text_style.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
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
          AppsFunction.verticalSpacing(20),
          Text(
            "$message \n ${AppString.pleaseWait}",
            style: AppsTextStyle.titleTextStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
