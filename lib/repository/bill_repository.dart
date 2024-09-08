import 'package:user_app/data/service/data_firebase_service.dart';

class BillRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    const String baseUrl = 'https://api.stripe.com/v1/payment_intents';

    final Map<String, String> headers = {
      'Authorization':
          'Bearer sk_test_51NxWNQAVUbXW3f6RxbSobZOWNsS7ZQvYMmWEGYEayvWWdsNEO8EKh12Ehlnezl6iXr8N7KA6gP2taLHDN2dTwesu002uaYJMYf',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final Map<String, String> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card',
    };
    final response = await _dataFirebaseService.postRequest(
        endpoint: "", body: body, baseUrl: baseUrl, headers: headers);
    return response;
    // PaymentIntentModel.fromMap(response);
  }

  Future<void> saveOrderDetails(
      {required Map<String, dynamic> orderMetailsMap,
      required String orderId}) async {
    await _dataFirebaseService.saveOrderDetails(
        orderMetailsMap: orderMetailsMap, orderId: orderId);
  }

  String calculateAmount(String amount) {
    final int parsedAmount = int.parse(amount) * 100;
    return parsedAmount.toString();
  }
}
