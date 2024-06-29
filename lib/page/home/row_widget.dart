import 'package:flutter/material.dart';

import '../../res/gobalcolor.dart';
import '../../res/textstyle.dart';

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
    Textstyle textstyle = Textstyle(context);
    return Row(
      children: [
        Text(
          text,
          style: textstyle.largestText,
        ),
        const Spacer(),
        InkWell(
          onTap: function,
          child: Icon(
            Icons.arrow_forward_ios,
            color: greenColor,
          ),
        )
        // IconButton(
        //     onPressed: function,
        //     icon: Icon(
        //       Icons.arrow_forward_ios,
        //       color: greenColor,
        //     )
        //     ),
      ],
    );
  }
}
