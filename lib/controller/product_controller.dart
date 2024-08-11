import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/service/provider/category_provider.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';

import '../repository/product_reposity.dart';

import '../res/appasset/icon_asset.dart';
import '../res/cartmethod.dart';
import '../service/provider/cart_product_counter_provider.dart';

class ProductController extends GetxController {
  final ProductReposity _firebaseAllDataRepositry;

  ProductController(this._firebaseAllDataRepositry);

  var categoryController = Get.put(CategoryController());

  var cartProductCountController = Get.put(CartProductCountController());
  var isCart = false.obs;

  checkIsCart({required bool isCart}) {
    this.isCart.value = isCart;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
      {required String category}) {
    try {
      return _firebaseAllDataRepositry.popularProductSnapshot(
          category: category);
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
      return _firebaseAllDataRepositry.productSnapshots(category: category);
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
      return _firebaseAllDataRepositry.similarProductSnapshot(
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

    //
  }

  void checkIfInCart({required ProductModel productModel}) {
    List<String> productIdListFromCartList =
        CartMethods.separeteProductIdUserCartList();
    isCart.value = productIdListFromCartList.contains(productModel.productId);
  }
}
