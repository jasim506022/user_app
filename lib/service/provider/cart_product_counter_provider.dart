import 'package:flutter/foundation.dart';
import 'package:user_app/const/const.dart';

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
