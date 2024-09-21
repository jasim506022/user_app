import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/address_controller.dart';
import 'package:user_app/controller/cart_controller.dart';
import 'package:user_app/res/cart_funtion.dart';

import '../repository/bill_repository.dart';
import '../res/constants.dart';
import '../res/routes/routesname.dart';
import '../service/provider/totalamountrpovider.dart';

class BillController extends GetxController {
  final BillRepository repository;

  var isLoading = false.obs;

  var paymentIntentData = Rxn<Map<String, dynamic>>();
  var currentPyamentIndex = 0.obs;
  bool isSucess = false;
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();
  var totalAmount = "".obs;

  var totalAmountController = Get.put(CartController());

  var addressController = Get.put(AddressController(
    Get.find(),
  ));

  setCurrentIndex(int index) {
    currentPyamentIndex.value = index;
  }

  var card = Payment.card.name.obs;

  setCurrentPayment(String card) {
    this.card.value = card;
  }

  BillController({required this.repository});

  setLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }

  Future<void> createPayment(String amount, String currency) async {
    try {
      isLoading.value = true;

      paymentIntentData.value =
          await repository.createPaymentIntent(amount, currency);
      var paymeinTents = paymentIntentData.value!['client_secret'];

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymeinTents,
              style: ThemeMode.dark,
              merchantDisplayName: 'ANNIE'));

      displayPaymentSheet().whenComplete(() {
        if (isSucess) {
          repository.saveOrderDetails(
              orderMetailsMap: orderMetailsMap("Payment By Carrd"),
              orderId: orderId);
          CartFunctions.clearCart();
          Fluttertoast.showToast(
              msg: "Congratulations, Order has been placed Successfully");
          Get.snackbar('Successfully', 'Successfully Done');
          Get.offAllNamed(RoutesName.placeOrderScreen);
        } else {
          Fluttertoast.showToast(msg: "Payment Cencle");
          isLoading.value = false;
        }
      });
    } catch (e, s) {
      if (kDebugMode) {
        print(s);
      }
    } finally {
      isLoading.value = true;
    }
  }

  Future<void> displayPaymentSheet() async {
    isLoading.value = true;
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntentData.value = null;
      isSucess = true;
      // print(isSucess);
    } on StripeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    } finally {
      isLoading.value = true;
    }
  }

  Map<String, dynamic> orderMetailsMap(String payment) {
    // FirebaseDatabase.saveOrderDetailsForUser(orderDetailsMap:
    return {
      "addressId": addressController.addressid.value, //
      "totalamount": totalAmount, //
      "orderBy": sharedPreference!.getString("uid"), //
      "productIds": sharedPreference!.getStringList("cartlist"), //
      "paymentDetails": payment, //
      "orderId": orderId, //
      "seller": CartFunctions.seperateSEllerSet(), //
      // seperateSEllerSet
      "orderTime": orderId, //
      "isSuccess": true, //
      "status": "normal", //
      "deliverydate": estimateDeliveryDate, //
      "deliverypartner": "BD-DEX",
      "trackingnumber": "bddex$orderId"
    };
    /*
    orderId: orderId)
        .whenComplete(() {
      FirebaseDatabase.saveOrderDetailsForSeller(orderDetailsMap: {
        "addressId": addressController.addressid.value, //
        "totalamount": totalAmount, //
        "orderBy": sharedPreference!.getString("uid"), //
        "productIds": sharedPreference!.getStringList("cartlist"), //
        "paymentDetails": payment, //
        "orderId": orderId, //
        "orderTime": orderId, //
        "isSuccess": true, //
        "seller": CartMethods.seperateSEllerSet(), //
        "status": "normal", //
        "deliverydate": estimateDeliveryDate, //
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
  */
  }

  String estimateDeliveryDate = DateTime.now()
      .add(const Duration(days: 15))
      .millisecondsSinceEpoch
      .toString();
}
