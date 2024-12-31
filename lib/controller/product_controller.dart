import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../model/app_exception.dart';
import '../model/products_model.dart';

import '../repository/product_reposity.dart';

import '../res/app_function.dart';
import '../res/app_asset/app_icons.dart';
import '../res/cart_funtion.dart';

import 'category_controller.dart';

class ProductController extends GetxController {
  var categoryController = Get.find<CategoryController>();

  final ProductReposity repository;
  ProductController({required this.repository});

  var isProductInCart = false.obs;

  var productItemQuantity = 1.obs;

  void resetQuantity() {
    productItemQuantity = 1.obs;
  }

// Popular Products Snapshot
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPopularProducts() {
    try {
      return repository.fetchPopularProducts(
          category: categoryController.getCategory);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: AppIcons.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }

// Product Snapshot
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryProducts() {
    try {
      return repository.fetchCategoryProducts(
          category: categoryController.getCategory);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: AppIcons.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: AppString.okay);
      }
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      {required ProductModel productModel}) {
    try {
      return repository.fetchSimilarProducts(productModel: productModel);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: AppIcons.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: AppString.okay);
      }
      rethrow;
    }
  }

  void updateQuantity({bool isIncrement = true}) {
    if (isIncrement) {
      productItemQuantity++;
    } else {
      if (productItemQuantity.value == 1) {
        AppsFunction.flutterToast(msg: "The Quantity cannot be less then 1");
      } else {
        productItemQuantity--;
      }
    }
  }

  void verifyProductInCart({required String productId}) {
    isProductInCart.value =
        CartFunctions.separateProductID().contains(productId);
  }

  void addItemToCart({
    required String productId,
    required String sellerId,
  }) {
    CartFunctions.addItemToCart(
      productId: productId,
      quantity: productItemQuantity.value,
      sellerId: sellerId,
    );

    isProductInCart.value = true;
  }
}
