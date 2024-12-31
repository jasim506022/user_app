import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import '../model/products_model.dart';
import '../res/app_string.dart';
import '../res/app_asset/image_asset.dart';
import 'empty_widget.dart';
import '../loading_widget/loading_list_product_widget.dart';
import 'product_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    this.productListType = ProductListType.regular,
    this.isScroll = true,
  });

  final ProductListType productListType;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return Obx(() => StreamBuilder(
          stream: productListType == ProductListType.regular
              ? productController.fetchCategoryProducts()
              : productController.fetchPopularProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingListProductWidget();
            }
            if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty ||
                snapshot.hasError) {
              return EmptyWidget(
                image: ImagesAsset.error,
                title: snapshot.hasError
                    ? '${AppString.errorOccure} ${snapshot.error}'
                    : AppString.noDataAvailable,
              );
            }
            if (snapshot.hasData) {
              return _buildProductGrid(snapshot);
            }
            return const LoadingListProductWidget();
          },
        ));
  }

  GridView _buildProductGrid(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return GridView.builder(
      shrinkWrap: true,
      physics: isScroll
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: snapshot.data!.docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .76,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        ProductModel productModel =
            ProductModel.fromMap(snapshot.data!.docs[index].data());

        return ProductWidget(
          productModel: productModel,
        );
      },
    );
  }
}

enum ProductListType { regular, popular }
