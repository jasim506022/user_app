import 'package:flutter/widgets.dart';

import 'loading_addres_swidget.dart';

class LoadingListAddressWidget extends StatelessWidget {
  const LoadingListAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const LoadingAddressWidget();
      },
    );
  }
}