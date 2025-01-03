import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../repository/bill_repository.dart';
import '../res/app_constant.dart';
import '../res/app_function.dart';
import '../res/app_asset/app_icons.dart';
import '../res/cart_funtion.dart';
import '../res/constants.dart';
import '../res/routes/routes_name.dart';
import 'address_controller.dart';
import 'cart_controller.dart';

class BillController extends GetxController {
  final BillRepository repository;

  //Observable variable for reactive UI Update

  var isLoading = false.obs;
  Map<String, dynamic> paymentIntentData = {};
  var currentPyamentIndex = 0.obs;
  var card = Payment.card.name.obs;
  var isSucess = false.obs;

  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  var totalAmountController = Get.find<CartController>();
  AddressController addressController = Get.find();

  BillController({required this.repository});

  void setLoading(bool isLoading) => this.isLoading.value = isLoading;

  void setCurrentPaymentIndex(int index) => currentPyamentIndex.value = index;

  void setCurrentPayment(String card) => this.card.value = card;

  Future<void> createPayment(String amount, String currency) async {
    try {
      if (!await _checkInternetConnection()) return;
      setLoading(true);

      paymentIntentData =
          await repository.createPaymentIntent(amount, currency);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'ANNIE'));

      await displayPaymentSheet(amount);
    } catch (e) {
      AppsFunction.flutterToast(msg: e.toString());
      setLoading(false);
    } finally {
      setLoading(false);
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    setLoading(true);
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntentData = {};
      isSucess.value = true;
      if (isSucess.value) {
        _processSuccessfullPayment(double.parse(amount));
      } else {
        AppsFunction.flutterToast(msg: "Payment Cencle");

        setLoading(false);
      }
    } on StripeException catch (e) {
      AppsFunction.flutterToast(msg: e.toString());
      setLoading(false);
    } catch (e) {
      AppsFunction.flutterToast(msg: e.toString());
      setLoading(false);
    }
  }

  void _processSuccessfullPayment(double amount) {
    repository.saveOrderDetails(
        orderMetailsMap: orderMetailsMap("Payment By Carrd", amount),
        orderId: orderId);
    CartFunctions.clearCart();
    Fluttertoast.showToast(
        msg: "Congratulations, Order has been placed Successfully");
    Get.snackbar('Successfully', 'Successfully Done');
    Get.offAllNamed(RoutesName.placeOrderScreen);
  }

  Future<bool> _checkInternetConnection() async {
    if (await AppsFunction.internetChecking()) {
      AppsFunction.errorDialog(
        icon: AppIcons.warningIcon,
        title: "No Internet Connection",
        content: "Please check your internet settings and try again.",
        buttonText: "Okay",
      );
      return false;
    }
    return true;
  }

  Map<String, dynamic> orderMetailsMap(String payment, double amount) {
    return {
      "addressId": addressController.addressid.value, //
      "totalamount": amount, //
      "orderBy": AppConstant.sharedPreference!
          .getString(AppString.uidSharedPreference), //
      "productIds": AppConstant.sharedPreference!
          .getStringList(AppString.cartListSharedPreference), //
      "paymentDetails": payment, //
      "orderId": orderId, //
      "seller": CartFunctions.seperateSellerSet(), //
      "orderTime": orderId, //
      "isSuccess": true, //
      "status": "normal", //
      "deliverydate": estimateDeliveryDate, //
      "deliverypartner": "BD-DEX",
      "trackingnumber": "bddex$orderId"
    };
  }

  String estimateDeliveryDate = DateTime.now()
      .add(const Duration(days: 15))
      .millisecondsSinceEpoch
      .toString();
}
