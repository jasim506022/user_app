// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_app/res/constants.dart';

import '../../controller/address_controller.dart';
import '../../res/cartmethod.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/totalamountrpovider.dart';

class PaymentIntentModel {
  final String id;
  final String clinetSecret;
  final String amount;

  PaymentIntentModel({
    required this.id,
    required this.clinetSecret,
    required this.amount,
  });

// What is Factory Class
  factory PaymentIntentModel.fromMap(Map<String, dynamic> map) {
    return PaymentIntentModel(
      id: map['id'] as String,
      clinetSecret: map['clinetSecret'] as String,
      amount: map['amount'] as String,
    );
  }
}

class ApiServices {
  final String baseUrl = 'https://api.stripe.com/v1/payment_intents';

  final Map<String, String> headers = {
    'Authorization':
        'Bearer sk_test_51NxWNQAVUbXW3f6RxbSobZOWNsS7ZQvYMmWEGYEayvWWdsNEO8EKh12Ehlnezl6iXr8N7KA6gP2taLHDN2dTwesu002uaYJMYf',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, String> body) async {
    final Uri url = Uri.parse("$baseUrl$endpoint");
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}

class PaymentRepository {
  final ApiServices apiService = ApiServices();
  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    final Map<String, String> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card',
    };
    final response = await apiService.postRequest('/', body);
    return response;
    // PaymentIntentModel.fromMap(response);
  }

  String calculateAmount(String amount) {
    final int parsedAmount = int.parse(amount) * 100;
    return parsedAmount.toString();
  }
}

class PaymentViewModel extends GetxController {
  final PaymentRepository repository;
  var addressController = Get.put(AddressController(
    Get.find(),
  ));

  var isLoading = false.obs;
  var paymentIntent = Rxn<PaymentIntentModel>();
  var paymentIntentData = Rxn<Map<String, dynamic>>();
  var currentPyamentIndex = 0.obs;
  bool isSucess = false;

  var totalAmount = Rxn<String>();

  String orderId = DateTime.now().millisecondsSinceEpoch.toString();
  var totalAmountController = Get.put(TotalAmountController());

  setCurrentIndex(int index) {
    currentPyamentIndex.value = index;
  }

  var card = Payment.card.name.obs;

  setCurrentPayment(String card) {
    this.card.value = card;
  }

  PaymentViewModel({required this.repository});

  setLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }

  Future<void> createPayment(String amount, String currency) async {
    isLoading.value = true;
    try {
      // paymentIntent.value =
      paymentIntentData.value =
          await repository.createPaymentIntent(amount, currency);
      var paymeinTents = paymentIntentData.value!['client_secret'];
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  // paymentIntentData.value!['client_secret'],
                  paymeinTents,
              style: ThemeMode.dark,
              merchantDisplayName: 'ANNIE'));

      displayPaymentSheet()
      .whenComplete(() {
        if (isSucess) {
          orderDetaisl("Payment By Carrd");
          Get.snackbar('Successfull', 'Successful');

          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const PlaceOrderScreen(),
          //     ),
          //     (route) => false);
        } else {
          print("Bangladesh is Good");

          isLoading.value = false;
        }
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to create payment intent');
    } finally {
      isLoading.value = false;
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) async {
        paymentIntentData.value = null;
        // isSucess = true;
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // ignore: use_build_context_synchronously
      // showDialog(
      //     // ignore: use_build_context_synchronously
      //     context: context,
      //     builder: (_) => const AlertDialog(
      //           content: Text("Cancelled "),
      //         ));
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  orderDetaisl(String payment) {
    FirebaseDatabase.saveOrderDetailsForUser(orderDetailsMap: {
      "addressId": addressController.addressid.value,
      "totalamount": totalAmount,
      "orderBy": sharedPreference!.getString("uid"),
      "productIds": sharedPreference!.getStringList("cartlist"),
      "paymentDetails": payment,
      "orderId": orderId,
      "seller": CartMethods.seperateSEllerSet(),
      // seperateSEllerSet
      "orderTime": orderId,
      "isSuccess": true,
      "status": "normal",
      "deliverydate": estimateDeliveryDate,
      "deliverypartner": "BD-DEX",
      "trackingnumber": "bddex$orderId"
    }, orderId: orderId)
        .whenComplete(() {
      FirebaseDatabase.saveOrderDetailsForSeller(orderDetailsMap: {
        "addressId": addressController.addressid.value,
        "totalamount": totalAmount,
        "orderBy": sharedPreference!.getString("uid"),
        "productIds": sharedPreference!.getStringList("cartlist"),
        "paymentDetails": payment,
        "orderId": orderId,
        "orderTime": orderId,
        "isSuccess": true,
        "seller": CartMethods.seperateSEllerSet(),
        "status": "normal",
        "deliverydate": estimateDeliveryDate,
        "deliverypartner": "BD-DEX",
        "trackingnumber": "bddex$orderId"
      }, orderId: orderId)
          .whenComplete(() {
        CartMethods.clearCart();
        Fluttertoast.showToast(
            msg: "Congratulations, Order has been placed Successfully");
      });

      orderId = "";
    });
  }

  String estimateDeliveryDate = DateTime.now()
      .add(const Duration(days: 15))
      .millisecondsSinceEpoch
      .toString();
}
