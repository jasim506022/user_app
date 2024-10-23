import 'package:flutter/material.dart';

import 'loading_product_card_widget.dart';

class LoadingListProudctCardWidget extends StatelessWidget {
  const LoadingListProudctCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) => const LoadingProductCardWidget(),
    );
  }
}
