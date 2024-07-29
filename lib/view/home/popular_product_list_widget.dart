import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controller/product_controller.dart';
import '../../model/productsmodel.dart';
import '../../res/appasset/image_asset.dart';
import '../../widget/single_empty_widget.dart';
import '../../widget/single_loading_product_widget.dart';
import 'single_popular_widget.dart';

class PopularProductListWidget extends StatelessWidget {
  const PopularProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController(
      Get.find(),
    ));
    return SizedBox(
        height: Get.height * .19,
        width: double.infinity,
        child: Obx(
          () => StreamBuilder(
              stream: productController.popularProductSnapshot(
                  category: productController.categoryController.getCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const LoadingSingleProductWidget();
                    },
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty ||
                    snapshot.hasError) {
                  return SingleEmptyWidget(
                    image: ImagesAsset.errorSingle,
                    title: snapshot.hasError
                        ? 'Error Occure: ${snapshot.error}'
                        : 'No Data Available',
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length > 5
                      ? 5
                      : snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ProductModel productModel =
                        ProductModel.fromMap(snapshot.data!.docs[index].data());
                    return ChangeNotifierProvider.value(
                      value: productModel,
                      child: const SingleProductWidget(),
                    );
                  },
                );
              }),
        ));
  }
}
