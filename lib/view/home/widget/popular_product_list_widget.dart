import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/product_controller.dart';
import '../../../model/products_model.dart';
import '../../../res/app_string.dart';
import '../../../res/app_asset/app_imges.dart';
import '../../../widget/single_empty_widget.dart';
import '../../../loading_widget/loading_single_product_widget.dart';
import 'single_popular_widget.dart';

class PopularProductListWidget extends StatelessWidget {
  const PopularProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return SizedBox(
        height: 145.h,
        width: double.infinity,
        child: Obx(
          () => StreamBuilder(
              stream: productController.fetchPopularProducts(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingSingleProductWidget();
                }

                if (snapshot.hasError) {
                  return SingleEmptyWidget(
                    image: AppImages.errorSingle,
                    title: '${AppString.errorOccure} ${snapshot.error}',
                  );
                }

                if (data == null || data.docs.isEmpty) {
                  return const SingleEmptyWidget(
                    image: AppImages.errorSingle,
                    title: AppString.noDataAvailable,
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.docs.length > 5 ? 5 : data.docs.length,
                    itemBuilder: (context, index) {
                      ProductModel productModel =
                          ProductModel.fromMap(data.docs[index].data());
                      return SingleProductWidget(
                        productModel: productModel,
                      );
                    },
                  );
                }
                return const LoadingSingleProductWidget();
              }),
        ));
  }
}
