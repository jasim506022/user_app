import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/repository/product_reposity.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';

class SearchControllers extends GetxController {
  ProductReposity productReposity = ProductReposity();
  TextEditingController minPriceTEC = TextEditingController();
  TextEditingController maxPriceTEC = TextEditingController();
  TextEditingController searchTextTEC = TextEditingController();

  var selectSearchCategory = "All".obs;

  var allProductList = <ProductModel>[].obs;
  var searchProductList = <ProductModel>[].obs;
  var filterProductList = <ProductModel>[].obs;

  var isSearch = false.obs;
  var isFilter = false.obs;

  @override
  void onInit() {
    minPriceTEC.text = "0.0";
    maxPriceTEC.text = "10000.0";
    super.onInit();
  }

  void setCategory(String category) => selectSearchCategory.value = category;

  void updateProductList(String text) {
    searchProductList.clear();
    var searchText = text.toLowerCase();

    final productListToSearch =
        isFilter.value ? filterProductList : allProductList;

    searchProductList.addAll(productListToSearch.where((productModel) =>
        productModel.productname!.toLowerCase().contains(searchText)));

    setSearch(true);
  }

  void filterListAddProduct() {
    filterProductList.clear();

    double minPrice = double.parse(minPriceTEC.text);
    double maxPrice = double.parse(maxPriceTEC.text);

    filterProductList.addAll(allProductList.where((productModel) {
      final double effectivePrice = AppsFunction.productPrice(
        productModel.productprice!,
        productModel.discount!.toDouble(),
      );
      return effectivePrice >= minPrice && effectivePrice <= maxPrice;
    }));

    setFilter(true);
  }

  void setSearch(bool isSearch) => this.isSearch.value = isSearch;

  void setFilter(bool isFilter) => this.isFilter.value = isFilter;

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return productReposity.productSnapshots(
          category: selectSearchCategory.value);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }
}
