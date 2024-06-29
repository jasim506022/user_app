import 'package:flutter/material.dart';
import 'package:user_app/res/gobalcolor.dart';
import 'package:user_app/res/textstyle.dart';

import '../../res/constants.dart';
import '../../res/utils.dart';

class PaymentWidgetMethod extends StatelessWidget {
  const PaymentWidgetMethod({
    super.key,
    required this.currentPyamentIndex,
    required this.index,
  });

  final int currentPyamentIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    Textstyle textstyle = Textstyle(context);
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
              border: Border.all(
                  color: currentPyamentIndex == index
                      ? greenColor
                      : Theme.of(context).cardColor,
                  width: 2),
              color: utils.green50,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                paymentList[index].icon!,
                height: 60,
                width: 60,
              ),
              Text(paymentList[index].title!, style: textstyle.mediumTextbold),
            ],
          ),
        ));
  }
}
