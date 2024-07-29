import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';
import '../../model/productsmodel.dart';
import '../../res/appasset/image_asset.dart';
import '../../res/constants.dart';
import '../../res/routes/routesname.dart';
import '../../widget/single_empty_widget.dart';
import 'loading_similar_widet.dart';
import 'similar_product_widget.dart';

class SimilarProductList extends StatelessWidget {
  const SimilarProductList({
    super.key,
    required this.productModel,
  });

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController(Get.find()));
    return SizedBox(
      height: 150,
      width: mq.width,
      child: StreamBuilder(
        stream: productController.similarProductSnapshot(
            productModel: productModel!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSimilierWidget();
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return SingleEmptyWidget(
              image: ImagesAsset.errorSingle,
              title: 'No Data Available',
            );
          } else if (snapshot.hasError) {
            return SingleEmptyWidget(
              image: ImagesAsset.errorSingle,
              title: 'Error Occure: ${snapshot.error}',
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length > 5
                    ? 5
                    : snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ProductModel models =
                      ProductModel.fromMap(snapshot.data!.docs[index].data());
                  return InkWell(
                    onTap: () {
                      Get.offAndToNamed(
                        RoutesName.productDestailsPage,
                        arguments: models,
                      );
                    },
                    child: SimilarProductWidget(models: models),
                  );
                });
          }
          return const LoadingSimilierWidget();
        },
      ),
    );
  }
}
