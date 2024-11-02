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

import 'profile_controller.dart';

class CartController extends GetxController {
  CartRepository repository;

  var profileController = Get.find<ProfileController>();

  CartController({required this.repository});
  var cartItemCounter = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCartItemCount();
  }

  void initializeCartItemCount() {
    final cartList = sharedPreference
        ?.getStringList(StringConstant.cartListSharedPreference);
    if (cartList != null && cartList.isNotEmpty) {
      cartItemCounter.value = cartList.length - 1;
    }
  }

  int get itemCount => cartItemCounter.value;
  incrementCartItem() {
    ++cartItemCounter;
  }

  decrementCartItem() {
    --cartItemCounter;
  }

  var totalAmount = 0.0.obs;

  void updateTotalAmount(ProductModel productModel, int itemIndex) {
    totalAmount.value += ((AppsFunction.productPrice(
          productModel.productprice!,
          productModel.discount!.toDouble(),
        ) *
        CartFunctions.seperateProductQuantiyList()[itemIndex]));
  }

  void removeValue(double productPrice) {
    totalAmount.value -= productPrice;
  }

  void resetTotalAmount() {
    totalAmount = 0.0.obs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartSellerSnapshot() {
    try {
      return repository.cartSellerSnapshot();
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");

        if (cartItemCounter.value == 1) {
          Get.back();
        }
      }
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartproductSnapshot(
      {required String sellerId}) {
    try {
      return repository.cartProductSnapshot(sellerId: sellerId);
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
    print(cartItemCounter.value);
    List<String> cartList = sharedPreference!
        .getStringList(StringConstant.cartListSharedPreference)!;

    String itemToRemove = cartList.firstWhere(
      (element) => element.contains(productId),
      orElse: () => '',
    );

    if (itemToRemove.isNotEmpty) {
      cartList.remove(itemToRemove);

      try {
        profileController.updateUserCartData(map: {"cartlist": cartList});
        AppsFunction.flutterToast(msg: "Item remove Successfully");

        sharedPreference!
            .setStringList(StringConstant.cartListSharedPreference, cartList);

        CartFunctions.separateProductID();
        CartFunctions.seperateProductQuantiyList();

        // var controller = Get.put(CartProductCountController());

        // var controller = Get.find<ProductController>();
        // controller.decrementCartItem();

        --cartItemCounter.value;
        if (cartItemCounter.value != 0) {
          print("Bangladesh");
          cartSellerSnapshot();
        }
      } catch (e) {
        print(cartItemCounter.value);
        AppsFunction.flutterToast(msg: e.toString());
      }
    } else {
      AppsFunction.flutterToast(msg: "Item not found in cart");
    }
  }
}
