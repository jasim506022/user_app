import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/search_controller.dart';
import '../../model/productsmodel.dart';

import '../../loading_widget/loading_list_product_widget.dart';

import 'widget/search_bar_widget.dart';
import 'widget/search_product_grid_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = Get.find<SearchControllers>();
  @override
  void initState() {
    searchController.searchTextTEC.text = "";
    searchController.setCategory("All");
    searchController.minPriceTEC.text = "0.00";
    searchController.maxPriceTEC.text = "10000.00";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Search Products",
          ),
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
    return Expanded(
      child: Obx(
        () => StreamBuilder(
          stream: searchController.productSnapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              searchController.allProductList.value = snapshot.data!.docs
                  .map((e) => ProductModel.fromMap(e.data()))
                  .toList();

              return SearchProductGridWidget(
                  searchController: searchController);
            }

            return const LoadingListProductWidget();
          },
        ),
      ),
    );
  }
}
