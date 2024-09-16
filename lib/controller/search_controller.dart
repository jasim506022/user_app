import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/repository/product_reposity.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import 'category_controller.dart';

class SearchControllers extends GetxController {
  ProductReposity productReposity = ProductReposity();
  TextEditingController minPriceTEC = TextEditingController();
  TextEditingController maxPriceTEC = TextEditingController();
  TextEditingController searchTextTEC = TextEditingController();

  var categoryController = Get.put(CategoryController());

  var allProducts = <ProductModel>[].obs;
  var searchList = <ProductModel>[].obs;
  var filterList = <ProductModel>[].obs;
  var isSearchList = false.obs;
  var isfilter = false.obs;

  @override
  void onInit() {
    minPriceTEC.text = "0.0";
    maxPriceTEC.text = "10000.0";
    super.onInit();
  }

  void searchAddProduct({required ProductModel productModel}) {
    searchList.add(productModel);
  }

  void filterAddProduct({required ProductModel productModel}) {
    filterList.add(productModel);
  }

  void setSearch(bool isSearch) {
    isSearchList.value = isSearch;
  }

  void setFilter(bool isFilter) {
    isfilter.value = isFilter;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
      ) {
    try {
      return productReposity.productSnapshots(category: "All");
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
