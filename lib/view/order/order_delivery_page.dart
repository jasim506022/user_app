import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/model/order_model.dart';
import 'package:user_app/res/app_asset/app_imges.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/app_string.dart';

import 'widget/delivery_estimateion_card.dart';
import 'widget/delivery_infor_widget.dart';
import 'widget/order_product_details.dart';
import 'widget/order_status_widget.dart';

class OrderDeliveryPage extends StatelessWidget {
  const OrderDeliveryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.orderDelivery,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const DeliveryEstimationCard(),
                ),
                AppsFunction.verticalSpacing(15),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const DeliveryInfoWidget(),
                ),
                AppsFunction.verticalSpacing(15),
                if (orderModel.status == "normal")
                  const OrderStatusWidget(
                    image: AppImages.orderReadyForDelivery,
                    title: "Ready For Shifted",
                  ),
                if (orderModel.status == "shift")
                  const OrderStatusWidget(
                    image: AppImages.orderOutForDelivery,
                    title: "Product Ready for User",
                  ),
                if (orderModel.status == "complete")
                  const OrderStatusWidget(
                    image: AppImages.orderConfirmed,
                    title: "Order is Successfully Done",
                  ),
                AppsFunction.verticalSpacing(10),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const OrderProductDetails(),
                )
              ],
            ),
          )),
    );
  }
}
