import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/app_string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CardApiService {
  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    final Uri url = Uri.parse(AppString.cardBaseUrl);
    try {
      final Map<String, String> headers = {
        'Authorization': AppString.athorization,
        'Content-Type': AppString.contentType
      };
      final Map<String, String> body = {
        'amount': AppsFunction.convertDollarToTaka(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
