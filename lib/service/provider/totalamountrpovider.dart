import 'package:get/get.dart';

/*
class TotalAmountProvider extends ChangeNotifier {
  double amount = 0;

  double get getAmount => amount;

  setAmount(double amounts) async {
    amount = amounts;
    await Future.delayed(
      const Duration(milliseconds: 100),
      () {
        notifyListeners();
      },
    );
  }
}
*/

class TotalAmountController extends GetxController {
  var amount = 0.0.obs;

  // double get getAmount => amount;

  setAmount(double amounts) {
    amount.value = amounts;
  }
}
