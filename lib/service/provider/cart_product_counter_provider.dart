import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:user_app/res/constants.dart';

class CartProductCountProvider extends ChangeNotifier {
  int cartListItemCounter =
      (sharedPreference!.getStringList("cartlist")!.length) - 1;

  // setValue() {

  //   // Why we don
  //   cartListItemCounter =
  //       (sharedPreference!.getStringList("cartlist")!.length) - 1;
  //   notifyListeners();
  // }

  int get getCount => cartListItemCounter;

  addCartItem() {
    ++cartListItemCounter;
    notifyListeners();
  }

  removeCartItem() {
    --cartListItemCounter;
    notifyListeners();
  }
}

class CartProductCountController extends GetxController {
  var cartListItemCounter = 0.obs;

  @override
  void onInit() {
    cartListItemCounter.value =
        (sharedPreference!.getStringList("cartlist")!.length) - 1;
    super.onInit();
  }

  int get getCounts => cartListItemCounter.value;

  addCartItem() {
    ++cartListItemCounter;
  }

  removeCartItem() {
    --cartListItemCounter;
  }
}
