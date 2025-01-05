import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/bill_controller.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/constants.dart';
import '../payment_widget.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var billController = Get.find<BillController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.paymentMethod,
          style: AppsTextStyle.titleTextStyle,
        ),
        AppsFunction.verticleSpace(10),
        SizedBox(
            height: 120.h,
            width: 1.sw,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paymentList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    billController.currentPyamentIndex.value = index;
                    billController.card.value =
                        index == 0 ? Payment.card.name : Payment.bkash.name;
                  },
                  child: PaymentWidgetMethod(
                    index: index,
                    controller: billController,
                  ),
                );
              },
            )),
      ],
    );
  }
}
