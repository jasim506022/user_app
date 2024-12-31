import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/search_controller.dart';
import '../../../model/products_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../widget/empty_widget.dart';
import '../../../widget/product_widget.dart';

class SearchProductGridWidget extends StatelessWidget {
  const SearchProductGridWidget({
    super.key,
    required this.searchController,
  });

  final SearchControllers searchController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final productList = _getProductList();

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
          return ChangeNotifierProvider.value(
            value: productList[index],
            child: ProductWidget(
              productModel: productList[index],
            ),
          );
        },
      );
    });
  }

  List<ProductModel> _getProductList() {
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
