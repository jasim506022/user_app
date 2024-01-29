import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user_app/const/cartmethod.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

import '../../widget/empty_widget.dart';
import '../../widget/single_loading_product_widget.dart';
import 'cart_order_widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const EmptyWidget(
                image: 'asset/payment/empty.png',
                title: 'No Data Available',
              );
            } else if (snapshot.hasError) {
              return EmptyWidget(
                image: 'asset/payment/empty.png',
                title: 'Error Occure: ${snapshot.error}',
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index].data();
                  if (kDebugMode) {
                    print(data);
                  }
                  return FutureBuilder(
                    future: FirebaseDatabase.orderProductSnapshots(
                        snpshot: snapshot.data!.docs[index].data()),
                    builder: (context, datasnapshot) {
                      if (datasnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LoadingSingleProductWidget();
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const EmptyWidget(
                          image: 'asset/payment/empty.png',
                          title: 'No Product Available',
                        );
                      } else if (snapshot.hasError) {
                        return EmptyWidget(
                          image: 'asset/payment/empty.png',
                          title: 'Error Occure: ${snapshot.error}',
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
