import 'package:flutter/material.dart';

import 'widget/order_status_list_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderStatusListWidget(
      appBarTitle: "Order History",
      orderStatus: "complete",
    );
  }
}

/*

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "History Page",
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseDatabase.allCompleteSnapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return EmptyWidget(
                image: ImagesAsset.error,
                title: snapshot.hasError
                    ? 'Error Occure: ${snapshot.error}'
                    : 'No Data Available',
              );
            } else if (snapshot.hasError) {
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
                        return EmptyWidget(
                          image: ImagesAsset.error,
                          title: snapshot.hasError
                              ? 'Error Occure: ${snapshot.error}'
                              : 'No Data Available',
                        );
                      } else if (snapshot.hasError) {
                        return EmptyWidget(
                          image: ImagesAsset.error,
                          title: snapshot.hasError
                              ? 'Error Occure: ${snapshot.error}'
                              : 'No Data Available',
                        );
                      } else {
                        List<int> listItem =
                            CartFunctions.separateOrderItemQuantities((snapshot
                                .data!.docs[index]
                                .data())["productIds"]);
                        return CartOrderItemWidget(
                          // itemCount: datasnapshot.data!.docs.length,
                          document: datasnapshot.data!.docs,
                          // orderId: snapshot.data!.docs[index].id,
                          // separateQuantities: listItem,
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