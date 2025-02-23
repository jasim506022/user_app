import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/network_utili.dart';

import '../../controller/bill_controller.dart';
import '../../res/app_colors.dart';
import '../../res/app_constant.dart';
import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import 'widget/address_details_widget.dart';

import 'widget/payment_list.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var billController = Get.find<BillController>();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (!billController.isLoading.value) Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
          title: const Text(AppString.payBill),
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
                        AppsFunction.verticalSpacing(10),
                        const PaymentList(),
                        AppsFunction.verticalSpacing(15),
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
        NetworkUtils.executeWithInternetCheck(action: () async {
          if (billController.addressController.addressid.value.isNotEmpty) {
            billController.card.value == Payment.bkash.name
                ? Container()
                : await billController.createPayment('USD');
          } else {
            AppsFunction.flutterToast(msg: "Please Add a address");
          }
        });
      },
      child: Container(
        height: 50.h,
        alignment: Alignment.center,
        width: 1.sw,
        decoration: BoxDecoration(
            color: AppColors.accentGreen,
            borderRadius: BorderRadius.circular(15.r)),
        child: Text(
            billController.card.value == Payment.card.name
                ? AppString.paymentCard
                : AppString.paymentBkash,
            style:
                AppsTextStyle.mediumBoldText.copyWith(color: AppColors.white)),
      ),
    );
  }
}
