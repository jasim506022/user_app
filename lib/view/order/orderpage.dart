import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/order_controller.dart';
import 'package:user_app/res/cart_funtion.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

import '../../res/appasset/image_asset.dart';
import '../../widget/empty_widget.dart';
import '../../widget/single_loading_product_widget.dart';
import 'cart_order_widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order Screen Page",
          ),
        ),
        body: StreamBuilder(
          stream: orderController.allOrderSnapshots(),
          //  FirebaseDatabase.allOrderSnapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty ||
                snapshot.hasError) {
              return EmptyWidget(
                image: ImagesAsset.error,
                title: snapshot.hasError
                    ? 'Error Occure: ${snapshot.error}'
                    : 'No Data Available',
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  print(snapshot.data!.docs[index].data());
                  return FutureBuilder(
                    // productIds
                    future: orderController.orderProductSnapshots(
                        itemIDDetails:
                            snapshot.data!.docs[index].data()["productIds"]),

                    // FirebaseDatabase.orderProductSnapshots(
                    //     snpshot: snapshot.data!.docs[index].data()),
                    builder: (context, datasnapshot) {
                      if (datasnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LoadingSingleProductWidget();
                      } else if (!datasnapshot.hasData ||
                          datasnapshot.data!.docs.isEmpty ||
                          datasnapshot.hasError) {
                        return EmptyWidget(
                          image: ImagesAsset.error,
                          title: datasnapshot.hasError
                              ? 'Error Occure: ${datasnapshot.error}'
                              : 'No Data Available',
                        );
                      } else {
                        List<int> listItem =
                            CartFunctions.separateOrderItemQuantities((snapshot
                                .data!.docs[index]
                                .data())["productIds"]);

                        return CartOrderWidget(
                          itemCount: datasnapshot.data!.docs.length,
                          data: datasnapshot.data!.docs,
                          orderId: snapshot.data!.docs[index].id,
                          seperateQuantilies: listItem,
                        );
                      }
                    },
                  );
                },
              );
            }
          },
        ));
  }
}


/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/order_controller.dart';
import 'package:user_app/res/cartmethod.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

import '../../res/appasset/image_asset.dart';
import '../../widget/empty_widget.dart';
import '../../widget/single_loading_product_widget.dart';
import 'cart_order_widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order Screen Page",
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseDatabase.allOrderSnapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty ||
                snapshot.hasError) {
              return EmptyWidget(
                image: ImagesAsset.error,
                title: snapshot.hasError
                    ? 'Error Occure: ${snapshot.error}'
                    : 'No Data Available',
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: FirebaseDatabase.orderProductSnapshots(
                        snpshot: snapshot.data!.docs[index].data()),
                    builder: (context, datasnapshot) {
                      if (datasnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LoadingSingleProductWidget();
                      } else if (!datasnapshot.hasData ||
                          datasnapshot.data!.docs.isEmpty ||
                          datasnapshot.hasError) {
                        return EmptyWidget(
                          image: ImagesAsset.error,
                          title: datasnapshot.hasError
                              ? 'Error Occure: ${datasnapshot.error}'
                              : 'No Data Available',
                        );
                      } else {
                        List<int> listItem =
                            CartMethods.separateOrderItemQuantities((snapshot
                                .data!.docs[index]
                                .data())["productIds"]);

                        return CartOrderWidget(
                          itemCount: datasnapshot.data!.docs.length,
                          data: datasnapshot.data!.docs,
                          orderId: snapshot.data!.docs[index].id,
                          seperateQuantilies: listItem,
                        );
                      }
                    },
                  );
                },
              );
            }
          },
        ));
  }
}

*/
