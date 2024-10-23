import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/cart_controller.dart';
import '../../../res/app_colors.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';
import '../../../res/utils.dart';
import '../../../widget/dot_line_printer.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    var cartController = Get.find<CartController>();
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: utils.bottomTotalBill,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.r),
          topRight: Radius.circular(60.r),
        ),
      ),
      child: Obx(() {
        // print()
        final totalAmount = cartController.totalAmount.value;
        final subTotal = totalAmount + 50; // Fixed delivery amount
        print(totalAmount);
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 14.h),
            _buildAmountRow("Total Amount", totalAmount.toStringAsFixed(2)),
            _buildAmountRow("Delivery Charge", "50.00"),
            _buildAmountRow("Carry Bag Charge", "0.00"),
            SizedBox(height: 8.h),
            SizedBox(
              width: 1.sw,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            SizedBox(height: 8.h),
            _buildAmountRow("Sub Total (BDT)", subTotal.toStringAsFixed(2),
                isBold: true),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                Get.toNamed(RoutesName.billPage);
              },
              child: Container(
                height: 60.h,
                alignment: Alignment.center,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  "Continue",
                  style: AppsTextStyle.mediumTextbold
                      .copyWith(color: AppColors.white),
                ),
              ),
            ),
            SizedBox(height: 5.h),
          ],
        );
      }),
    );
  }

  Row _buildAmountRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: isBold
                ? AppsTextStyle.rowTextbold
                : AppsTextStyle.hintBoldTextStyle),
        Text(
          amount,
          style: AppsTextStyle.rowTextbold,
        ),
      ],
    );
  }
}
