import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/bill_controller.dart';

import '../../res/app_colors.dart';

import '../../res/apps_text_style.dart';
import '../../res/constants.dart';
import '../../res/utils.dart';

class PaymentWidgetMethod extends StatelessWidget {
  const PaymentWidgetMethod({
    super.key,
    required this.index,
    required this.controller,
  });
  final BillController controller;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15.w),
        child: Obx(
          () => Container(
            height: 100.h,
            width: 130.w,
            decoration: BoxDecoration(
                border: Border.all(
                    color: controller.currentPyamentIndex.value == index
                        ? AppColors.accentGreen
                        : Theme.of(context).cardColor,
                    width: 2),
                color: Utils.green50,
                borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  paymentList[index].icon!,
                  height: 70.h,
                  width: 60.w,
                ),
                Text(paymentList[index].title!,
                    style: AppsTextStyle.mediumTextbold),
              ],
            ),
          ),
        ));
  }
}
