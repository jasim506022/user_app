import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_string.dart';
import 'package:user_app/res/routes/routes_name.dart';
import 'package:user_app/view/order/widget/delivery_card_widget.dart';
import 'package:user_app/view/order/widget/order_item_widget.dart';

import '../../../model/order_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';

class OrderProductDetails extends StatelessWidget {
  const OrderProductDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context, listen: false);
    return DelivaryCardWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppString.order} ${orderModel.orderId}",
                style: AppsTextStyle.largeText,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutesName.orderDetailsPage,
                      arguments: orderModel);
                },
                child: Text(
                  "${AppString.orderDetails} >",
                  style: AppsTextStyle.mediumBoldText
                      .copyWith(color: AppColors.red),
                ),
              ),
            ],
          ),
          AppsFunction.verticalSpacing(25),
          Flexible(
            child: ChangeNotifierProvider.value(
              value: orderModel,
              child: const OrderItemWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
