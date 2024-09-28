import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/widget/text_form_field_widget.dart';

import '../../controller/search_controller.dart';
import '../../res/app_colors.dart';
import '../../model/productsmodel.dart';
import '../../res/appasset/image_asset.dart';
import '../../widget/empty_widget.dart';
import '../../widget/loading_product_widget.dart';
import '../../widget/product_widget.dart';
import 'filter_dialog_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = Get.put(SearchControllers());

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
              _buildSearchBar(),
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

              return _buildProductGridContent();
            }

            return const LoadingProductWidget();
          },
        ),
      ),
    );
  }

  Obx _buildProductGridContent() {
    return Obx(() {
      final productList = searchController.isFilter.value &&
              searchController.searchTextTEC.text.isEmpty
          ? searchController.filterProductList
          : searchController.isSearch.value &&
                  searchController.searchTextTEC.text.isNotEmpty
              ? searchController.searchProductList
              : searchController.allProductList;

      if (productList.isEmpty) {
        return EmptyWidget(
          image: ImagesAsset.error,
          title: 'No Data Available',
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
            child: const ProductWidget(),
          );
        },
      );
    });
  }

  SizedBox _buildSearchBar() {
    return SizedBox(
      height: 0.1.sh,
      width: 1.sw,
      child: Row(
        children: [
          Flexible(
              flex: 4,
              child: TextFormFieldWidget(
                isUdateDecoration: true,
                decoration: AppsFunction.inputDecoration(
                  hint: "Search Product Here",
                ),
                controller: searchController.searchTextTEC,
                autofocus: false,
                onChanged: (text) {
                  searchController.updateProductList(text);
                },
              )),
          IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.dialog(const FilterDialogWidget());
              },
              icon: Icon(
                FontAwesomeIcons.sliders,
                color: AppColors.greenColor,
              ))
        ],
      ),
    );
  }
}
