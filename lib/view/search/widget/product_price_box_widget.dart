import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/search_controller.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/text_form_field_widget.dart';

class ProductPriceBoxWidget extends StatelessWidget {
  const ProductPriceBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<ProductSearchController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.productPrice, style: AppsTextStyle.mediumBoldText),
        Row(
          children: [
            Expanded(
                child: CustomTextFormField(
                    hintText: AppString.minimumHintText,
                    controller: searchController.minPriceTEC)),
            AppsFunction.horizontalSpacing(15),
            Expanded(
              child: CustomTextFormField(
                  controller: searchController.maxPriceTEC,
                  hintText: AppString.maxiMumHintText),
            ),
          ],
        ),
      ],
    );
  }
}
