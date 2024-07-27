import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/service/provider/category_provider.dart';

import '../model/productsmodel.dart';
import '../model/profilemodel.dart';
import '../repository/product_reposity.dart';
import '../res/app_function.dart';
import '../res/cartmethod.dart';
import '../res/constants.dart';

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

  getUserInformationSnapshot() async {
    var snapshot = await _firebaseAllDataRepositry.getUserInformationSnapshot();

    if (snapshot.exists) {
      ProfileModel profileModel = ProfileModel.fromMap(snapshot.data()!);
      if (profileModel.status == "approved") {
        sharedPreference = await SharedPreferences.getInstance();
        await sharedPreference!.setString("uid", profileModel.uid!);
        await sharedPreference!.setString("email", profileModel.email!);
        await sharedPreference!.setString("name", profileModel.name!);
        await sharedPreference!.setString("imageurl", profileModel.imageurl!);
        await sharedPreference!.setString("phone", profileModel.phone!);
        List<String> list =
            profileModel.cartlist!.map((e) => e.toString()).toList();
        await sharedPreference!.setStringList("cartlist", list);
      } else {
        AppsFunction.flutterToast(msg: "User Doesn't Exist");
      }
    }
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
