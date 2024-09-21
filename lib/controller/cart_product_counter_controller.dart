import 'package:get/get.dart';
import 'package:user_app/res/constants.dart';

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
