import 'package:flutter/material.dart';

import 'widget/order_status_list_widget.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderStatusListWidget(
      appBarTitle: "Order Page",
      orderStatus: "normal",
    );
  }
}
