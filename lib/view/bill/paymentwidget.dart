import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/view/bill/exmaple.dart';
import '../../res/app_colors.dart';
import 'package:user_app/res/Textstyle.dart';

import '../../res/constants.dart';
import '../../res/utils.dart';

class PaymentWidgetMethod extends StatelessWidget {
  const PaymentWidgetMethod({
    super.key,
    // required this.currentPyamentIndex,
    required this.index,
  });

  // final int currentPyamentIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    final PaymentViewModel viewModel = Get.put(PaymentViewModel(
    repository: PaymentRepository(),
  ));
    Utils utils = Utils(context);
    // Textstyle Textstyle = Textstyle(context);
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Obx(
          () =>  Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
                border: Border.all(
                    color: viewModel. currentPyamentIndex.value == index
                        ?AppColors. greenColor
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
                Text(paymentList[index].title!, style: Textstyle.mediumTextbold),
              ],
            ),
          ),
        ));
  }
}
