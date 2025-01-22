import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';
import '../../../res/app_asset/app_imges.dart';
import '../../../widget/empty_widget.dart';
import '../../../loading_widget/loading_list_single_product_widget.dart';
import 'order_item_widget.dart';

class OrderStatusListWidget extends StatelessWidget {
  const OrderStatusListWidget({
    super.key,
    required this.appBarTitle,
    required this.orderStatus,
  });

  final String appBarTitle;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitle,
          ),
        ),
        body: StreamBuilder(
          // Stream of orders filtered by [orderStatus].
          stream: orderController.orderSnapshots(orderStatus: orderStatus),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingListSingleProductWidget();
            } else if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty ||
                snapshot.hasError) {
              return EmptyWidget(
                image: AppImages.error,
                title: snapshot.hasError
                    ? '${AppString.errorOccure}: ${snapshot.error}'
                    : AppString.noDataAvailable,
              );
              // Display the list of orders when data is available.
            } else if (snapshot.hasData) {
              // Convert the snapshot data to [OrderModel].
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final orderModel =
                      OrderModel.fromMap(snapshot.data!.docs[index].data());
                  return OrderItemWidget(
                      isCardDesign: true, orderModel: orderModel);
                },
              );
            } else {
              return const LoadingListSingleProductWidget();
            }
          },
        ));
  }
}
