import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/search_controller.dart';
import '../../model/products_model.dart';

import '../../loading_widget/loading_list_product_widget.dart';

import '../../res/app_string.dart';
import 'widget/search_bar_widget.dart';
import 'widget/search_product_grid_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppString.searchProduct),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              const SearchBarWidget(),
              _buildProductGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildProductGrid() {
    var searchController = Get.find<ProductSearchController>();
    return Expanded(
      child: Obx(
        () => StreamBuilder(
          stream: searchController.productSnapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingListProductWidget();
            }
            if (snapshot.hasData) {
              searchController.allProductList.value = snapshot.data!.docs
                  .map((e) => ProductModel.fromMap(e.data()))
                  .toList();

              return const SearchProductGridWidget();
            }

            return const LoadingListProductWidget();
          },
        ),
      ),
    );
  }
}
