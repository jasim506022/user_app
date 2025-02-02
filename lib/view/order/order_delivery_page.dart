import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/order_model.dart';
import '../../res/app_asset/app_imges.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import 'widget/delivery_estimateion_card.dart';
import 'widget/delivery_infor_widget.dart';
import 'widget/order_product_details.dart';
import 'widget/order_status_widget.dart';

class OrderOverviewPage extends StatelessWidget {
  const OrderOverviewPage({
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
                DeliveryEstimationCard(orderModel: orderModel),
                AppsFunction.verticalSpacing(15),
                DeliveryInfoWidget(orderModel: orderModel),
                AppsFunction.verticalSpacing(15),
/*
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
  */
                _buildOrderStatusWidget(orderModel.status),
                AppsFunction.verticalSpacing(10),
                OrderProductDetails(
                  orderModel: orderModel,
                )
              ],
            ),
          )),
    );
  }

  Widget _buildOrderStatusWidget(String status) {
    switch (status) {
      case AppString.normalOrderStatus:
        return const OrderStatusWidget(
          image: AppImages.orderReadyForDelivery,
          title: AppString.orderReadyForShifted,
        );
      case AppString.shiftOrderStatus:
        return const OrderStatusWidget(
          image: AppImages.orderOutForDelivery,
          title: AppString.productReadyForUser,
        );
      case AppString.completeOrderStatus:
        return const OrderStatusWidget(
          image: AppImages.orderConfirmed,
          title: AppString.orderSuccesfuulydone,
        );

      default:
        return const SizedBox.shrink(); // Empty widget for unknown statuses
    }
  }
}
