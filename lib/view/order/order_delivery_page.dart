import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/model/order_model.dart';
import 'package:user_app/res/appasset/image_asset.dart';

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
          "Order Delivery ",
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
                SizedBox(
                  height: 15.h,
                ),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const DeliveryInfoWidget(),
                ),
                SizedBox(
                  height: 15.h,
                ),
                if (orderModel.status == "normal")
                  OrderStatusWidget(
                    image: ImagesAsset.readyForDelivery,
                    title: "Ready For Shifted",
                  ),
                if (orderModel.status == "shift")
                  OrderStatusWidget(
                    image: ImagesAsset.deliveryOrder,
                    title: "Product Ready for User",
                  ),
                if (orderModel.status == "complete")
                  OrderStatusWidget(
                    image: ImagesAsset.confirmOrder,
                    title: "Order is Successfully Done",
                  ),
                SizedBox(
                  height: 10.h,
                ),
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
