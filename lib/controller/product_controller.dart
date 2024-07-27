import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_app/service/provider/category_provider.dart';

import '../model/productsmodel.dart';

import '../repository/product_reposity.dart';

import '../res/cartmethod.dart';


class ProductController extends GetxController {
  final ProductReposity _firebaseAllDataRepositry;

  ProductController(this._firebaseAllDataRepositry);

  var categoryController = Get.put(CategoryController());

  // var productModel = Rx<ProductModel>(ProductModel());
  var isCart = false.obs;

  var countNumber = 1.obs;

  updateProductCountNumber(bool isIncrement) {
    isIncrement ? countNumber.value++ : countNumber.value--;
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
          {required String category}) =>
      _firebaseAllDataRepositry.popularProductSnapshot(category: category);

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
          {required String category}) =>
      _firebaseAllDataRepositry.productSnapshots(category: category);

  void checkIfInCart({required ProductModel productModel}) {
    List<String> productIdListFromCartList =
        CartMethods.separeteProductIdUserCartList();
    isCart.value = productIdListFromCartList.contains(productModel.productId);
  }
}
