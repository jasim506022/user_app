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
  final CategoryController categoryController = Get.find<CategoryController>();
  final ProductReposity repository;

  // Observable variables
  var isProductInCart = false.obs;
  var productItemQuantity = 1.obs;

  ProductController({required this.repository});

  // Reset quantity to 1
  void resetQuantity() {
    productItemQuantity.value = 1;
  }

// Popular Products Snapshot
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPopularProducts() {
    return _fetchProducts(
      () => repository.fetchPopularProducts(
          category: categoryController.getCategory),
    );
  }

  // Fetch category products stream
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryProducts() {
    return _fetchProducts(() => repository.fetchCategoryProducts(
        category: categoryController.getCategory));
  }

  // Fetch similar products stream
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      ProductModel productModel) {
    return _fetchProducts(
        () => repository.fetchSimilarProducts(productModel: productModel));
  }

  // Common method for fetching products with error handling
  Stream<QuerySnapshot<Map<String, dynamic>>> _fetchProducts(
      Stream<QuerySnapshot<Map<String, dynamic>>> Function() fetchFunction) {
    try {
      return fetchFunction();
    } catch (e) {
      if (e is AppException) {
        _handleError(e);
      }
      rethrow;
    }
  }

  // Update quantity (increment or decrement)
  void updateQuantity({bool isIncrement = true}) {
    if (isIncrement) {
      productItemQuantity++;
    } else {
      if (productItemQuantity.value == 1) {
        AppsFunction.flutterToast(msg: AppString.theQuantityCannotBeLessThen1);
      } else {
        productItemQuantity--;
      }
    }
  }

// Check if the product is already in the cart
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

  void _handleError(AppException e) {
    AppsFunction.errorDialog(
      icon: AppIcons.warningIcon,
      title: e.title ?? AppString.errorOccure,
      content: e.message ?? AppString.someThingWentWrong,
      buttonText: AppString.okay,
    );
  }
}
