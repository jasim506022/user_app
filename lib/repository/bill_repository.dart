import 'package:user_app/data/service/data_firebase_service.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/constant/string_constant.dart';

class BillRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      final Map<String, String> headers = {
        'Authorization': StringConstant.athorization,
        'Content-Type': StringConstant.contentType
      };
      final Map<String, String> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      final response = await _dataFirebaseService.postRequest(
          endpoint: "",
          body: body,
          baseUrl: StringConstant.baseUrl,
          headers: headers);

      return response;
    } catch (e) {
      AppsFunction.flutterToast(msg: e.toString());
      rethrow;
    }
  }

  Future<void> saveOrderDetails(
      {required Map<String, dynamic> orderMetailsMap,
      required String orderId}) async {
    try {
      await _dataFirebaseService.saveOrderDetails(
          orderMetailsMap: orderMetailsMap, orderId: orderId);
    } catch (e) {
      AppsFunction.flutterToast(msg: e.toString());
    }
  }

  String calculateAmount(String amount) {
    final int parsedAmount = int.parse(amount) * 100;
    return parsedAmount.toString();
  }
}
