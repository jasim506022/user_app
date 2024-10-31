import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:user_app/loading_widget/loading_single_product_widget.dart';

import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';

import '../../../res/cart_funtion.dart';

import 'seller_product_widget.dart';

class OrderProductSection extends StatelessWidget {
  const OrderProductSection({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();

    return StreamBuilder(
      stream: orderController.sellerOrderSnapshot(
          sellerList:
              CartFunctions.separateOrderSellerCartList(orderModel.productIds)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingSingleProductWidget();
        }

        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text('No products available or an error occurred.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var sellerName = snapshot.data!.docs[index]["name"];
            var sellerId = snapshot.data!.docs[index]["uid"];
            return SellerProductWidget(
              sellerName: sellerName,
              orderModel: orderModel,
              sellerId: sellerId,
            );
          },
        );
      },
    );
  }
}
