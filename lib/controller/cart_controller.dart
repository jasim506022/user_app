import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_app/model/app_exception.dart';
import 'package:user_app/repository/sign_in_repository.dart';

import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/cart_funtion.dart';
import '../res/constants.dart';
import '../service/database/firebasedatabase.dart';
import 'cart_product_counter_controller.dart';
import '../service/provider/totalamountrpovider.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = CartRepository();

  var shareP = 0.obs;
  var sellerUser = <Map<String, dynamic>>[].obs;
  var cartStream = Rxn<Stream<QuerySnapshot<Map<String, dynamic>>>>();
  var cartProductSnapshots = Rxn<Stream<QuerySnapshot<Map<String, dynamic>>>>();

  // CartController(this._cartRepository);

  var totalAmountController = Get.put(TotalAmountController());

  @override
  void onInit() {
    super.onInit();

    if (sharedPreference!.getStringList("cartlist")!.length > 1) {
      cartStream.value = _cartRepository.cartSellerSnapshot();
      shareP.value = sharedPreference!.getStringList("cartlist")!.length;
    }
  }

  cartSellerSnapshot() {
    try {
      cartStream.value = _cartRepository.cartSellerSnapshot();
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
        if (shareP.value == 1) {
          Get.back();
        }
      }
    }
  }

  //

  cartproductSnapshot({required String sellerId}) {
    try {
      cartProductSnapshots.value =
          _cartRepository.cartProductSnapshot(sellerId: sellerId);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    }

    //
  }

  void removeProdctFromCart({required int index}) async {
    List<String> cartList = sharedPreference!.getStringList("cartlist")!;

    cartList.removeAt(index);

    await FirebaseDatabase.currentUserSnaphots()
        .update({"cartlist": cartList}).then((value) {
      AppsFunction.flutterToast(msg: "Item remove Successfully");

      sharedPreference!.setStringList("cartlist", cartList);

      CartFunctions.separateProductID();
      CartFunctions.separteProductQuantityUserCartList();

      var controller = Get.put(CartProductCountController());
      controller.removeCartItem();

      --shareP.value;

      cartSellerSnapshot();

      totalAmountController.setAmount(0);
    });
  }
}
