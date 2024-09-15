import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';

import '../repository/product_reposity.dart';

import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../service/provider/category_provider.dart';
import 'cart_product_counter_controller.dart';

class ProductController extends GetxController {
  final ProductReposity _productRepository;

  ProductController(this._productRepository);

  var categoryController = Get.find<CategoryController>();

  var cartProductCountController = Get.find<CartProductCountController>();

  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
      {required String category}) {
    try {
      return _productRepository.popularProductSnapshot(category: category);
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

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
      {required String category}) {
    try {
      return _productRepository.productSnapshots(category: category);
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

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    try {
      return _productRepository.similarProductSnapshot(
          productModel: productModel);
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
