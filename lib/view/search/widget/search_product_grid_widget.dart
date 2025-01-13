import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/search_controller.dart';
import '../../../model/products_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../widget/empty_widget.dart';
import '../../../widget/product_widget.dart';

class SearchProductGridWidget extends StatelessWidget {
  const SearchProductGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<ProductSearchController>();
    return Obx(() {
      final productList = _getProductList(searchController);

      if (productList.isEmpty) {
        return EmptyWidget(
          image: ImagesAsset.error,
          title: AppString.noDataAvailable,
        );
      }

      return GridView.builder(
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .78,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) {
          return ProductWidget(
            productModel: productList[index],
          );

          // ChangeNotifierProvider.value(
          //   value: productList[index],
          //   child: const ProductWidget(),
          // );
        },
      );
    });
  }

  List<ProductModel> _getProductList(ProductSearchController searchController) {
    if (searchController.isFilterEnabled.value &&
        searchController.searchTextTEC.text.isEmpty) {
      return searchController.filterProductList;
    }
    if (searchController.isSearchEnabled.value &&
        searchController.searchTextTEC.text.isNotEmpty) {
      return searchController.searchProductList;
    }
    return searchController.allProductList;
  }
}
