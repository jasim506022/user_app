import 'package:flutter/material.dart';


import 'loading_product_widget.dart';


class LoadingListProductWidget extends StatelessWidget {
  const LoadingListProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .78,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemCount: 20,
      itemBuilder: (context, index) {
        return const LoadingProductWidget();
      },
    );
  }
}
