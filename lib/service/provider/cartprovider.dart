import 'package:flutter/foundation.dart';
import 'package:user_app/const/const.dart';

class CartProductCounter extends ChangeNotifier {
  int cartListItemCounter =
      (sharedPreference!.getStringList("cartlist")!.length) - 1;

  setValue() {
    cartListItemCounter = 0;
    notifyListeners();
  }

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
