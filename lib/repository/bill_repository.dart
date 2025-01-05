import 'package:user_app/data/service/card_api_service.dart';
import 'package:user_app/data/service/data_firebase_service.dart';
import 'package:user_app/model/order_model.dart';
import 'package:user_app/res/app_function.dart';

class BillRepository {
  final _dataFirebaseService = DataFirebaseService();
  final _apiService = CardApiService();

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    return _apiService.createPaymentIntent(amount, currency);
  }

/*
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
*/
  Future<void> uploadOrderSnapshots({required OrderModel orderModel}) async {
    try {
      await _dataFirebaseService.uploadOrderSnapshots(
        orderModel: orderModel,
      );
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
