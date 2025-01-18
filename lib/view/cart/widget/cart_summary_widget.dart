import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/cart_controller.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';
import '../../../res/utils.dart';
import '../../../widget/dot_line_printer.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();

    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Utils.bottomTotalBill,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.r),
          topRight: Radius.circular(60.r),
        ),
      ),
      child: Obx(() {
        // print()
        final totalAmount = cartController.totalAmount.value;
        final subTotal = totalAmount +
            double.parse(
                AppString.priceDelliveryCharge); // Fixed delivery amount

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppsFunction.verticalSpacing(14),
            _buildAmountDetails(
              totalAmount: totalAmount,
              subTotal: subTotal,
            ),
            AppsFunction.verticalSpacing(20),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutesName.billPage);
              },
              child: Container(
                height: 60.h,
                alignment: Alignment.center,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  AppString.continueText,
                  style: AppsTextStyle.mediumTextbold
                      .copyWith(color: AppColors.white),
                ),
              ),
            ),
            AppsFunction.verticalSpacing(5)
          ],
        );
      }),
    );
  }

  Widget _buildDivider() {
    return SizedBox(
      width: double.infinity,
      child: CustomPaint(
        painter: DottedLinePainter(),
      ),
    );
  }

  Widget _buildAmountDetails({
    required double totalAmount,
    required double subTotal,
  }) {
    return Column(
      children: [
        _buildAmountRow(AppString.totalAmount, totalAmount.toStringAsFixed(2)),
        _buildAmountRow(
            AppString.delliveryCharge, AppString.priceDelliveryCharge),
        _buildAmountRow(
            AppString.carryBagCharge, AppString.priceCarryBagCharge),
        SizedBox(height: 8.h),
        _buildDivider(),
        SizedBox(height: 8.h),
        _buildAmountRow(AppString.subTotal, subTotal.toStringAsFixed(2),
            isBold: true),
      ],
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
