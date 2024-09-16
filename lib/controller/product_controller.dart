import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';

import '../repository/product_reposity.dart';

import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/cart_funtion.dart';
import 'category_controller.dart';
import 'cart_product_counter_controller.dart';

class ProductController extends GetxController {
  var categoryController = Get.find<CategoryController>();
  var cartProductCountController = Get.find<CartProductCountController>();
  final ProductReposity _productRepository;

  ProductController(this._productRepository);

  var isCart = false.obs;
  var counter = 1.obs;

  void resetCounter() {
    counter = 1.obs;
  }

  void checkIsCart({required String productId}) {
    isCart = CartFunctions.separateProductID().contains(productId).obs;
  }

  void addItemToCart({
    required String productId,
    required String sellerId,
  }) {
    if (!isCart.value) {
      CartFunctions.addItemToCartWithSeller(
        productId: productId,
        productCounter: counter.value,
        seller: sellerId,
      );
      isCart.value = true;
    }
  }

  incrementOrDecrement({bool? isIncrement = true}) {
    if (isIncrement!) {
      counter++;
    } else {
      if (counter.value == 1) {
        AppsFunction.flutterToast(msg: "The Quantity cannot be less then 1");
      } else {
        counter--;
      }
    }
  }

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
