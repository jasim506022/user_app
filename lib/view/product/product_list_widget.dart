
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controller/product_controller.dart';
import '../../model/productsmodel.dart';
import '../../res/appasset/image_asset.dart';
import '../../service/provider/category_provider.dart';
import '../../widget/empty_widget.dart';
import '../../widget/loading_product_widget.dart';
import '../../widget/product_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    this.isPopular = false,
    this.isScroll = true,
  });

  final bool? isPopular;
  final bool? isScroll;

  @override
  Widget build(BuildContext context) {
    final ProductController firebaseAllDataController =
        Get.put(ProductController(Get.find()));

    var categoryController = Get.put(CategoryController());
    return Obx(() => StreamBuilder(
          stream: isPopular!
              ? firebaseAllDataController.popularProductSnapshot(
                  category: categoryController.getCategory)
              : firebaseAllDataController.productSnapshots(
                  category: categoryController.getCategory),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingProductWidget();
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return EmptyWidget(
                  image: ImagesAsset.error, title: 'No Data Available');
            }
            if (snapshot.hasError) {
              return EmptyWidget(
                  image: ImagesAsset.error,
                  title: 'Error Occured: ${snapshot.error}');
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: isScroll!
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .78,
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
          },
        ));
  }



}

