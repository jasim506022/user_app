import 'package:flutter/material.dart';

import 'single_loading_product_widget.dart';

class ListLoadingSingleProductWidget extends StatelessWidget {
  const ListLoadingSingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) => const LoadingSingleProductWidget(),
    );
  }
}
