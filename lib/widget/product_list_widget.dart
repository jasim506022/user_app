import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controller/product_controller.dart';
import '../model/productsmodel.dart';
import '../res/appasset/image_asset.dart';
import 'empty_widget.dart';
import '../loading_widget/loading_list_product_widget.dart';
import 'product_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    this.isPopular = false,
    this.isScroll = true,
  });

  final bool isPopular;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return Obx(() => StreamBuilder(
          stream: isPopular
              ? productController.popularProductSnapshot()
              : productController.productSnapshots(),
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
                    ? 'Error Occure: ${snapshot.error}'
                    : 'No Data Available',
              );
            }
            if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true,
                physics: isScroll
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .76, //78
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  ProductModel productModel =
                      ProductModel.fromMap(snapshot.data!.docs[index].data());
                  return ChangeNotifierProvider.value(
                    value: productModel,
                    child: const ProductWidget(),
                  );
                },
              );
            }
            return const LoadingListProductWidget();
          },
        ));
  }
}
