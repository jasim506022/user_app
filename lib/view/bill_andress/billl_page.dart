import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/bill_controller.dart';
import '../../res/app_colors.dart';
import '../../res/apps_text_style.dart';
import '../../res/constants.dart';
import 'widget/address_details_widget.dart';
import 'payment_widget.dart';

class BillPage extends StatelessWidget {
  const BillPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BillController billController = Get.find();
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (billController.isLoading.value) {
                } else {
                  Get.back();
                }
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
          title: const Text("Pay Bill"),
        ),
        body: Obx(
          () => billController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AddressDetailsWidget(),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildPaymentMethodSection(billController),
                        SizedBox(
                          height: 15.h,
                        ),
                        _buildPaymentActionButtion(billController, context),
                      ],
                    ),
                  ),
                ),
        ));
  }

  InkWell _buildPaymentActionButtion(
      BillController billController, BuildContext context) {
    return InkWell(
      onTap: () async {
        int amount =
            billController.totalAmountController.totalAmount.value.toInt();

        billController.card.value == Payment.bkash.name
            ? Container()
            : await billController.createPayment(amount.toString(), 'USD');
      },
      child: Container(
        height: 40.h,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(15.r)),
        child: Text(
            billController.card.value == Payment.card.name
                ? "Payment By Card"
                : "Payment By Bkask",
            style:
                AppsTextStyle.mediumTextbold.copyWith(color: AppColors.white)),
      ),
    );
  }

  _buildPaymentMethodSection(BillController billController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: AppsTextStyle.largestText,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
            height: 100.h,
            width: 1.sw,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paymentList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    billController.currentPyamentIndex.value = index;
                    index == 0
                        ? billController.card.value = Payment.card.name
                        : billController.card.value = Payment.bkash.name;
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
