import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:user_app/const/const.dart';
import 'package:user_app/const/gobalcolor.dart';
import 'package:user_app/model/addressmodel.dart';
import 'package:user_app/page/bill/addresscreen.dart';
import 'package:user_app/page/bill/paymentwidget.dart';
import 'package:user_app/service/database/firebasedatabase.dart';
import 'package:user_app/service/provider/totalamountrpovider.dart';
import '../../const/cartmethod.dart';
import '../../const/textstyle.dart';
import 'placeorderscrren.dart';
import 'addresswidget.dart';
import 'loadingaddresswidget.dart';

class BillPage extends StatefulWidget {
  const BillPage({
    super.key,
  });

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  int currentAddressIndex = 0;

  int currentPyamentIndex = 0;

  String addressid = "";

  bool isLoading = false;

  List<AddressModel> _addressModelList = [];

  String card = Payment.card.name;

  Map<String, dynamic>? paymentIntentData;
  String? totalAmount;

  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var amount = Provider.of<TotalAmountProvider>(context, listen: false)
          .amount
          .toInt();
      totalAmount = amount.toString();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Pay Bill"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Delivery Address",
                            style: textstyle.largeBoldText
                                .copyWith(color: greenColor)),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddOrUpdateAddressScreen(),
                                ));
                          },
                          child: Text("+Add",
                              style: textstyle.largeBoldText
                                  .copyWith(color: greenColor)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 280,
                      child: StreamBuilder(
                        stream: FirebaseDatabase.alluserAddressSnapshot(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return const LoadingAddressWidget();
                              },
                            );
                          } else if (snapshot.hasData) {
                            final addressData = snapshot.data!.docs;
                            _addressModelList = addressData
                                .map((e) => AddressModel.fromMap(e.data()))
                                .toList();

                            addressid = _addressModelList.first.addressId!;
                            if (_addressModelList.isNotEmpty) {
                              return ListView.builder(
                                itemCount: _addressModelList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: InkWell(
                                      onTap: () {
                                        currentAddressIndex = index;
                                        addressid =
                                            _addressModelList[index].addressId!;
                                        setState(() {});
                                      },
                                      child: AddressWidget(
                                        currentIndex: currentAddressIndex,
                                        addressModel: _addressModelList[index],
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                          return ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return const LoadingAddressWidget();
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Payment Method",
                      style: textstyle.largestText,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: paymentList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                currentPyamentIndex = index;
                                index == 0
                                    ? card = Payment.card.name
                                    : card = Payment.bkash.name;
                                setState(() {});
                              },
                              child: PaymentWidgetMethod(
                                currentPyamentIndex: currentPyamentIndex,
                                index: index,
                              ),
                            );
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        card == Payment.bkash.name
                            ? await bkashPayment()
                            : cardPayment();
                      },
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                            card == Payment.card.name
                                ? "Payment By Card"
                                : "Payment By Bkask",
                            style: textstyle.mediumTextbold
                                .copyWith(color: white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  bkashPayment() async {
    setState(() {
      isLoading = true;
    });
    final flutterBkash = FlutterBkash();
    final result = await flutterBkash
        .pay(
      context: context, // BuildContext context
      amount: double.parse(totalAmount!), // amount as double
      merchantInvoiceNumber: "invoice123",
    )
        .then((value) {
      orderDetaisl("Payment By Bkash");
    });
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${result.trxId}")));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const PlaceOrderScreen(),
          ),
          (route) => false);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> cardPayment() async {
    try {
      setState(() {
        isLoading = true;
      });
      paymentIntentData = await createPaymentIntent(
          totalAmount!, 'USD'); //json.decode(response.body);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'ANNIE'))
          .then((value) {
        isLoading = false;
      });
      displayPaymentSheet().whenComplete(() {
        orderDetaisl("Payment By Carrd");
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Succesffully")));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PlaceOrderScreen(),
            ),
            (route) => false);
      });
    } catch (e, s) {
      if (kDebugMode) {
        setState(() {
          isLoading = false;
        });
        print(s);
      }
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) async {
        paymentIntentData = null;
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
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51NxWNQAVUbXW3f6RxbSobZOWNsS7ZQvYMmWEGYEayvWWdsNEO8EKh12Ehlnezl6iXr8N7KA6gP2taLHDN2dTwesu002uaYJMYf',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print('err charging user: ${err.toString()}');
      }
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  orderDetaisl(String payment) {
    FirebaseDatabase.saveOrderDetailsForUser(orderDetailsMap: {
      "addressId": addressid,
      "totalamount": totalAmount,
      "orderBy": sharedPreference!.getString("uid"),
      "productIds": sharedPreference!.getStringList("cartlist"),
      "paymentDetails": payment,
      "orderId": orderId,
      "orderTime": orderId,
      "isSuccess": true,
      "status": "normal",
      "deliverydate": estimateDeliveryDate,
      "deliverypartner": "BD-DEX",
      "trackingnumber": "bddex$orderId"
    }, orderId: orderId)
        .whenComplete(() {
      FirebaseDatabase.saveOrderDetailsForSeller(orderDetailsMap: {
        "addressId": addressid,
        "totalamount": totalAmount,
        "orderBy": sharedPreference!.getString("uid"),
        "productIds": sharedPreference!.getStringList("cartlist"),
        "paymentDetails": payment,
        "orderId": orderId,
        "orderTime": orderId,
        "isSuccess": true,
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
