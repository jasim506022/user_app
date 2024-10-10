import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:user_app/model/order_model.dart';

import 'package:user_app/res/Textstyle.dart';

import '../../res/app_colors.dart';

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
          "Order Details",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ship & Bill To",
                style: Textstyle.largeBoldText
                    .copyWith(color: AppColors.red, fontSize: 20),
              ),
              OrderReceiverDetailsWidget(orderModel: orderModel),
              OrderProductSection(
                orderModel: orderModel,
              ),
              OrderDetailsWidget(orderModel: orderModel),
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
