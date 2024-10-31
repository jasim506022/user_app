import 'package:flutter/material.dart';

import 'widget/order_status_list_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderStatusListWidget(
      appBarTitle: "Order History",
      orderStatus: "complete",
    );
  }
}
