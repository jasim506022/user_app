import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';

import '../repository/product_reposity.dart';

import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/cart_funtion.dart';
import '../res/constant/string_constant.dart';
import '../res/constants.dart';
import 'category_controller.dart';

class ProductController extends GetxController {
  var categoryController = Get.find<CategoryController>();

  final ProductReposity repository;
  ProductController({required this.repository});

  @override
  void onInit() {
    updateCartItemCount();
    super.onInit();
  }

  // Cart Item Counter
  var cartItemCounter = 0.obs;
  void updateCartItemCount() {
    cartItemCounter.value = (sharedPreference!
            .getStringList(StringConstant.cartListSharedPreference)!
            .length) -
        1;
  }

  int get itemCount => cartItemCounter.value;
  incrementCartItem() {
    ++cartItemCounter;
  }

  decrementCartItem() {
    --cartItemCounter;
  }

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

// Popular Products Snapshot
  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot() {
    try {
      return repository.popularProductSnapshot(
          category: categoryController.getCategory);
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

// Product Snapshot
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return repository.productSnapshots(
          category: categoryController.getCategory);
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
      return repository.similarProductSnapshot(productModel: productModel);
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
