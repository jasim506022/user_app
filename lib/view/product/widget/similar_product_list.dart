import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/product_controller.dart';
import '../../../model/products_model.dart';
import '../../../res/app_asset/app_imges.dart';
import '../../../widget/single_empty_widget.dart';
import '../../../loading_widget/loading_similar_widet.dart';
import 'similar_product_widget.dart';

class SimilarProductList extends StatelessWidget {
  const SimilarProductList({
    super.key,
    required this.productModel,
    required this.isCart,
  });

  final ProductModel productModel;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return SizedBox(
      height: 150.h,
      width: 1.sw,
      child: StreamBuilder(
        stream: productController.fetchSimilarProducts(productModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSimilierWidget();
          } else if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty ||
              snapshot.hasError) {
            return SingleEmptyWidget(
                image: AppImages.errorSingle,
                title: snapshot.hasError
                    ? '${AppString.errorOccure} ${snapshot.error}'
                    : AppString.noDataAvailable);
          }
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length > 5
                    ? 5
                    : snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ProductModel productModel =
                      ProductModel.fromMap(snapshot.data!.docs[index].data());
                  return SimilarProductWidget(
                    isCartBack: isCart,
                    productModel: productModel,
                  );
                });
          }
          return const LoadingSimilierWidget();
        },
      ),
    );
  }
}
