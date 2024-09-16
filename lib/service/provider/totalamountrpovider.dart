

import 'package:get/get.dart';

class TotalAmountController extends GetxController {
  var amount = 0.0.obs;

  // double get getAmount => amount;

  setAmount(double amounts) {
    amount.value = amounts;
  }
}
