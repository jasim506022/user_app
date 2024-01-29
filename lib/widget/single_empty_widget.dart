import 'package:flutter/material.dart';
import 'package:user_app/const/textstyle.dart';

class SingleEmptyWidget extends StatelessWidget {
  const SingleEmptyWidget({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        children: [
          Image.asset(
            image,
            height: 160,
            width: 160,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(title, style: Textstyle.emptyTestStyle),
          )
        ],
      ),
    );
  }
}
