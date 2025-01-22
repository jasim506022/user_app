import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/order_controller.dart';
import '../../../model/order_model.dart';
import '../../../model/products_model.dart';
import '../../../res/app_asset/app_imges.dart';
import '../../../res/app_string.dart';
import '../../../res/cart_funtion.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/card_product_widget.dart';
import '../../../widget/dot_line_printer.dart';
import '../../../widget/empty_widget.dart';
import '../../../loading_widget/loading_single_product_widget.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    this.isCardDesign = false,
    this.sellerId,
    required this.orderModel,
  });
  final String? sellerId;
  final bool isCardDesign;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    // Extract product quantities and IDs
    List<int> productQuantities =
        CartManager.getOrderProductQuantities(orderModel.productIds);

    List<String> productIDs =
        CartManager.getOrderProductsIds(orderModel.productIds);

    return FutureBuilder(
      future: sellerId == null
          ? orderController.orderProductSnapshots(productIDs: productIDs)
          : orderController.sellerProductSnapshot(
              productIDs: productIDs, sellerId: sellerId!),
      builder: (context, orderProductSnapshot) {
        if (orderProductSnapshot.connectionState == ConnectionState.waiting) {
          return const LoadingSingleProductWidget();
        } else if (!orderProductSnapshot.hasData ||
            orderProductSnapshot.data!.docs.isEmpty ||
            orderProductSnapshot.hasError) {
          return EmptyWidget(
            image: AppImages.error,
            title: orderProductSnapshot.hasError
                ? '${AppString.errorOccure}: ${orderProductSnapshot.error}'
                : AppString.noDataAvailable,
          );
        } else {
          var productDocs = orderProductSnapshot.data!.docs;
          return InkWell(
            onTap: () {
              if (isCardDesign) {
                Get.toNamed(AppRoutesName.deliveryScreen,
                    arguments: orderModel);
              }
            },
            child: isCardDesign
                ? _buildCardDesign(context, productDocs, productQuantities)
                : _buildListView(productDocs, productQuantities),
          );
        }
      },
    );
  }

  /// Builds the card design view for the order item.
  Widget _buildCardDesign(
      BuildContext context,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data,
      List<int> quantities) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Container(
        padding: EdgeInsets.all(5.r),
        margin: EdgeInsets.all(5.r),
        height: data.length * 110.h,
        child: _buildListView(data, quantities),
      ),
    );
  }

  /// Builds the list view for displaying products.
  Widget _buildListView(List<QueryDocumentSnapshot<Map<String, dynamic>>> data,
      List<int> quantities) {
    return ListView.separated(
      separatorBuilder: (context, index) => CustomPaint(
        painter: DottedLinePainter(),
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        ProductModel productModel = ProductModel.fromMap(data[index].data());
        return OrderProductWidget(
          quantity: quantities[index],
          productModel: productModel,
        );
      },
    );
  }
}
