import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:user_app/model/order_model.dart';
import 'package:user_app/res/app_string.dart';

import '../../res/app_colors.dart';

import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import 'widget/order_details_widget.dart';
import 'widget/order_product_section.dart';
import 'widget/order_receiver_details_widget.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.orderDetails,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString.shipAndBill,
                style: AppsTextStyle.largeBoldText
                    .copyWith(color: AppColors.red, fontSize: 20),
              ),
              AppsFunction.verticalSpacing(10),
              OrderReceiverDetailsWidget(orderModel: orderModel),
              OrderProductSection(
                orderModel: orderModel,
              ),
              AppsFunction.verticalSpacing(10),
              OrderDetailsWidget(orderModel: orderModel),
              AppsFunction.verticalSpacing(100),
            ],
          ),
        ),
      ),
    );
  }
}
