import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/product_controller.dart';

import '../model/app_exception.dart';
import '../model/productsmodel.dart';
import '../repository/cart_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/cart_funtion.dart';
import '../res/constant/string_constant.dart';
import '../res/constants.dart';

import 'cart_product_counter_controller.dart';
import 'profile_controller.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = CartRepository();

  var shareP = 0.obs;

  var profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();

    if (sharedPreference!
            .getStringList(StringConstant.cartListSharedPreference)!
            .length >
        1) {
      shareP.value = sharedPreference!
          .getStringList(StringConstant.cartListSharedPreference)!
          .length;
    }
  }

  var totalAmount = 0.0.obs;

  void setAmount(ProductModel productModel, int itemIndex) {
    totalAmount.value += ((AppsFunction.productPrice(
          productModel.productprice!,
          productModel.discount!.toDouble(),
        ) *
        CartFunctions.seperateProductQuantiyList()[itemIndex]));
  }

  setSzeo() {
    totalAmount = 0.0.obs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartSellerSnapshot() {
    try {
      return _cartRepository.cartSellerSnapshot();
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
      rethrow;
    }
  }

  //

  Stream<QuerySnapshot<Map<String, dynamic>>> cartproductSnapshot(
      {required String sellerId}) {
    try {
      return _cartRepository.cartProductSnapshot(sellerId: sellerId);
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

  void removeProductFromCart({required String productId}) async {
    List<String> cartList = sharedPreference!
        .getStringList(StringConstant.cartListSharedPreference)!;

    String itemToRemove = cartList.firstWhere(
      (element) => element.contains(productId),
      orElse: () => '',
    );

    if (itemToRemove.isNotEmpty) {
      cartList.remove(itemToRemove);

      try {
        profileController.updateUserData(map: {"cartlist": cartList});
        AppsFunction.flutterToast(msg: "Item remove Successfully");

        sharedPreference!
            .setStringList(StringConstant.cartListSharedPreference, cartList);

        CartFunctions.separateProductID();
        CartFunctions.seperateProductQuantiyList();

        // var controller = Get.put(CartProductCountController());
        var controller = Get.find<ProductController>();
        controller.decrementCartItem(); //

        --shareP.value;

        cartSellerSnapshot();
      } catch (e) {
        AppsFunction.flutterToast(msg: "Failed to remove item");
      }
    } else {
      AppsFunction.flutterToast(msg: "Item not found in cart");
    }
  }
}


/*

  void removeProdctFromCart({required String index}) async {
    var stringId = "";
    List<String> cartList = sharedPreference!.getStringList("cartlist")!;
    print("Example $index");
    for (var indes in cartList) {
      if (indes.contains(index)) {
        stringId = indes;
        print(stringId);
      }
    }

    cartList.remove(stringId);

    FirebaseDatabase.currentUserSnaphots()
        .update({"cartlist": cartList}).then((value) {
      AppsFunction.flutterToast(msg: "Item remove Successfully");

      sharedPreference!.setStringList("cartlist", cartList);

      CartFunctions.separateProductID();
      CartFunctions.separteProductQuantityUserCartList();

      var controller = Get.put(CartProductCountController());
      controller.removeCartItem();

      --shareP.value;

      cartSellerSnapshot();

      // totalAmountController.setAmount(0);
    });
  }
}
*/
