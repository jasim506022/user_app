import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/order_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/custom_round_action_button.dart';
import 'delivery_card_widget.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return DelivaryCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order #${orderModel.orderId}",
              style: AppsTextStyle.largeBoldText.copyWith(
                color: AppColors.accentGreen,
              )),
          AppsFunction.verticleSpace(7),
          Text(
              "Placed On ${AppsFunction.formatDeliveryDate(datetime: orderModel.orderId)}",
              style: AppsTextStyle.mediumText600
                  .copyWith(color: Theme.of(context).hintColor)),
          AppsFunction.verticleSpace(25),
          Align(
            alignment: Alignment.center,
            child: CustomRoundActionButton(
              onTap: () {
                Get.offAndToNamed(RoutesName.mainPage, arguments: 0);
              },
              title: "Home Page",
            ),
          ),
        ],
      ),
    );
  }
}
