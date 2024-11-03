import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/cart_controller.dart';
import '../../../loading_widget/loading_list_product_card_widget.dart';
import '../../../model/productsmodel.dart';
import '../../../widget/dot_line_printer.dart';

import 'cart_widget.dart';

class ProductListBySellerWidget extends StatelessWidget {
  const ProductListBySellerWidget({
    super.key,
    required this.sellerId,
  });

  final String sellerId;

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return StreamBuilder(
      stream: cartController.cartproductSnapshot(sellerId: sellerId),
      builder: (context, productSnashot) {
        if (productSnashot.connectionState == ConnectionState.waiting) {
          return const LoadingListProudctCardWidget();
        } else if (productSnashot.hasData) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 1.sw,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: productSnashot.data!.docs.length,
            itemBuilder: (context, itemIndex) {
              ProductModel productModel = ProductModel.fromMap(
                  productSnashot.data!.docs[itemIndex].data());
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                cartController.updateTotalAmount(productModel, itemIndex);
              });

              return CardWidget(
                productModel: productModel,
                index: itemIndex,
              );
            },
          );
        }
        return const LoadingListProudctCardWidget();
      },
    );
  }
}
