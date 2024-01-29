import 'package:flutter/foundation.dart';

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
